//
//  DataProvider.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation

protocol DataProviderProtocol {
    func fetchFightersLocally(_ completion: @escaping (Result<[Characters], Error>) -> Void)
    var fighterModel: [Characters] {get}
    func fetchFightersFirebase(_ completion: @escaping (Result<[Characters], Error>) -> Void)
}

class DataProvider : DataProviderProtocol {
    private var loader: FighterDataSourceProtocol
    var fighterModel: [Characters] = [Characters]()

    func fetchFightersLocally(_ completion: @escaping (Result<[Characters], Error>) -> Void) {
        loader.fetchFightersListLocally { [weak self] (result) in
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
    
    func fetchFightersFirebase(_ completion: @escaping (Result<[Characters], Error>) -> Void) {
        loader.fetchFightersListFirebase { [weak self] (result) in
            switch result {
            case .success(let fighterList):
                completion(.success(fighterList))
                self?.fighterModel.append(contentsOf: fighterList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    init(loader: FighterDataSourceProtocol) {
        self.loader = loader
    }
}
