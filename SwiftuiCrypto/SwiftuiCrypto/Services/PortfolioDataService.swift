//
//  PortfolioDataService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/13/23.
//

import Foundation
import CoreData

final class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data를 로딩 중에 오류가 발생했습니다! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - PUBLIC
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // portfolio에 coin이 이미 있는지 확인하는 로직
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Portfolio Entity를 가져오는 중에 오류가 발생했습니다! \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Core Data를 저장 중에 오류가 발생했습니다! \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
