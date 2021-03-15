//
//  Networking.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation
import Firebase


protocol MKNetwork {
   static func getFighters(_ completion: @escaping(Result<CharacterModel?, Error>) -> Void)
}

struct LocalNetworking: MKNetwork {
    
    let fighters = [Characters]()
    
   static func getFighters(_ completion: @escaping (Result<CharacterModel?, Error>) -> Void) {
        if let jsonPath: String = Bundle.main.path(forResource: "Kombat", ofType: "json"), let jsonData: Data = NSData(contentsOfFile: jsonPath) as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let data = try jsonDecoder.decode(CharacterModel.self, from: jsonData)
                completion(.success(data))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
}


struct FirebaseNetworking {
    static func getFighters(_ completion: @escaping (Result<DataSnapshot, Error>) -> Void) {
        let ref = Database.database().reference()
        ref.child("characters").observe(.value) { (snapshot) in
            for item in snapshot.children {
                completion(.success(item as! DataSnapshot))
            }
        }
    }
    //ERROR???
}


