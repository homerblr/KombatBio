//
//  CharacterModel.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation

// MARK: - Character

struct CharacterModel: Codable {
    let characters: [Characters]

    enum CodingKeys: String, CodingKey {
        case characters = "characters"
    }
}

// MARK: - CharacterDetail
struct Characters: Codable {
    let id: Int
    let name: String
    let realName: String
    let gender: String
    let thumbImageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case realName = "real_name"
        case gender = "gender"
        case thumbImageURL = "thumb_image_URL"
    }

}
