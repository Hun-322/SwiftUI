//
//  PortfolioView.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/12/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("보유 자산 수정")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            })
        }
    }
}

struct PortfolioView_PreView: PreviewProvider {
    static var previews: some View {
        PortfolioView()
        // environmentObject - 데이터를 뷰 계층 구조에서 전파하기 위한 방법, 데이터를 전역적으로 사용 가능한 상태로 만들 수 있다.
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
        }
        .frame(height: 120)
        .padding(.leading)
    }
    
    
    private func getCurrnetValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("\(selectedCoin?.symbol.uppercased() ?? "")의 현재 가격: ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrnecy() ?? "")
            }
            Divider()
            HStack {
                Text("보유 중인 코인 수:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("현재 가격:")
                Spacer()
                Text(getCurrnetValue().asCurrnecy())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("저장")
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currnetHoldings != Double(quantityText) ?
                 1.0 : 0.0
                )
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        
        guard let coin = selectedCoin else { return }
        
        // save to portfolio
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
