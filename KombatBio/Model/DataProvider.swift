//
//  DataProvider.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation

protocol DataProviderProtocol {
    func fetchFighters(_ completion: @escaping (Result<[Characters], Error>) -> Void)
    var fighterModel: [Characters] {get}
}

class DataProvider : DataProviderProtocol {
    private var loader: FighterDataSourceProtocol
    var fighterModel: [Characters] = [Characters]()

    func fetchFighters(_ completion: @escaping (Result<[Characters], Error>) -> Void) {
        loader.fetchFightersList { [weak self] (result) in
            switch result {
            case .success(let fighterList):
                completion(.success(fighterList))
                self?.fighterModel.append(contentsOf: fighterList)
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    init(loader: FighterDataSourceProtocol) {
        self.loader = loader
    }
}
