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

protocol BaseNetworkingProtocol {
    static func fetch<T: Decodable>(path: String, _ completion: @escaping (Result<T?, Error>) -> ())
}

extension BaseNetworkingProtocol {
    static func fetch<T: Decodable>(path: String, _ completion: @escaping (Result<T?, Error>) -> ()) {
        if let jsonData: Data = NSData(contentsOfFile: path) as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let data = try jsonDecoder.decode(T.self, from: jsonData)
                completion(.success(data))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        } else {
            completion(.failure(NSError(domain: "Path Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Path"])))
        }
    }
}

struct LocalNetworking: BaseNetworkingProtocol {
    
    let fighters = [Characters]()
    static func fetch<T>(path: String, _ completion: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        if let jsonPath: String = Bundle.main.path(forResource: "Kombat", ofType: "json") {
            fetch(path: jsonPath, completion)
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


