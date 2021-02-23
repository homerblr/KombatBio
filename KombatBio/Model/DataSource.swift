//
//  DataProvider.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation

protocol FighterDataSourceProtocol {
    func fetchFightersList(_ completion: @escaping (Result<[CharacterDetail], Error>) -> Void)
}

struct DataSource: FighterDataSourceProtocol {
    func fetchFightersList(_ completion: @escaping (Result<[CharacterDetail], Error>) -> Void) {
        LocalNetworking.getFighters { (result) in
            switch result {
            case .success(let fighterModel):
                guard let fighterModel = fighterModel else { return }
                completion(.success(fighterModel.characterDetails))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
   
}
