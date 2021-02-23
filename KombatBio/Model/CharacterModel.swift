//
//  CharacterModel.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation

// MARK: - Character

struct Character: Codable {
    let characterDetails: [CharacterDetail]

    enum CodingKeys: String, CodingKey {
        case characterDetails = "characterDetails"
    }
}

// MARK: - CharacterDetail
struct CharacterDetail: Codable {
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
