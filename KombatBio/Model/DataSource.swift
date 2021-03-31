//
//  DataProvider.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation

protocol FighterDataSourceProtocol {
    func fetchFightersListLocally(_ completion: @escaping (Result<[Characters], Error>) -> Void)
    func fetchFightersListFirebase(_ completion: @escaping (Result<[Characters], Error>) -> Void)
}

struct DataSource: FighterDataSourceProtocol {
    func fetchFightersListLocally(_ completion: @escaping (Result<[Characters], Error>) -> Void) {
//        LocalNetworking.fetch { (result) in
//            switch result {
//            case .success(let fighterModel):
//                guard let fighterModel = fighterModel else { return }
//                completion(.success(fighterModel.characters))
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func fetchFightersListFirebase(_ completion: @escaping (Result<[Characters], Error>) -> Void) {
        var fighters = [Characters]()
        FirebaseNetworking.getFighters { (result) in
            switch result {
            case .success(let fighterModel):
                let transformedFighter = Characters(snapshot: fighterModel)
                fighters.append(transformedFighter)
                completion(.success(fighters))
            case .failure(let err):
                print(err)
            }
        }
    }
    
   
}
