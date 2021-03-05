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
    let motto: String
    let gender: String
    let description: String
    let thumbImageURL: String
    let fullSizeImageURL: String
    let introVideo: String
    let storyEndingVideoID: String
    let comboVideoID: String
    let finisherVideoID: String
   

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case realName = "real_name"
        case motto = "motto"
        case gender = "gender"
        case description = "description"
        case thumbImageURL = "thumb_image_URL"
        case fullSizeImageURL = "fullsize_image_URL"
        case introVideo = "intro_video"
        case storyEndingVideoID = "story_ending_video_id"
        case comboVideoID = "combo_video_id"
        case finisherVideoID =  "finisher_video_id"
    }

}
