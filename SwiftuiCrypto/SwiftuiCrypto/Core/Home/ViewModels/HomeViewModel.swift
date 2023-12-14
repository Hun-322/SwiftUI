import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    // Combine에서 비동기 작업을 수행한 후 해당 작업의 수명을 관리하는 데 사용
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updated allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
        // .store - sink를 구독하고 있는 동안 메모리 누수를 방지하기 위해 cancellables 컬렉션에 현재의 구독을 저장
            .store(in: &cancellables)
        
        // update PortfolioCoins
        $allCoins
        // 두 개 이상의 Publisher로부터 발생한 최신 이벤트들을 결합하여 새로운 이벤트를 생성하는 데 사용됨(융합 느낌)
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioCoins: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioCoins.first(where: { coin.id == $0.coinID }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "시가총액", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd == nil ? 1.02 : data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "거래량", value: data.vloume)
        let btcDominace = StatisticModel(title: "BTC 도미넌스", value: data.btcDominace)
        
        let portfolioValue = portfolioCoins.reduce(0) { $0 + $1.currentHoldingsValue }
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        let percentageChange = (portfolioValue - previousValue) / previousValue * 100
        
        let portfolio = StatisticModel(title: "보유자산 가치", value: portfolioValue.asCurrnecy(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominace, portfolio])
        return stats
    }
}
