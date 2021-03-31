//
//  CharacterModel.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import Foundation
import Firebase

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
    let fandomURL: String
    let strength1: String
    let strength2: String
    let weakness1: String
    let weakness2: String
    //let ref: DatabaseReference?
   

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
        case fandomURL = "fandom_url"
        case strength1 = "strength1"
        case strength2 = "strength2"
        case weakness1 = "weakness1"
        case weakness2 = "weakness2"
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as? Int ?? 0
        name = snapshotValue["name"] as? String ?? ""
        realName = snapshotValue["real_name"] as? String ?? ""
        motto = snapshotValue["motto"] as? String ?? ""
        gender = snapshotValue["gender"] as? String ?? ""
        description = snapshotValue["description"] as? String ?? ""
        thumbImageURL = snapshotValue["thumb_image_URL"] as? String ?? ""
        fullSizeImageURL = snapshotValue["fullsize_image_URL"] as? String ?? ""
        introVideo = snapshotValue["intro_video"] as? String ?? ""
        storyEndingVideoID = snapshotValue["story_ending_video_id"] as? String ?? ""
        comboVideoID = snapshotValue["combo_video_id"] as? String ?? ""
        finisherVideoID = snapshotValue["finisher_video_id"] as? String ?? ""
        fandomURL = snapshotValue["fandom_url"] as? String ?? ""
        strength1 = snapshotValue["strength1"] as? String ?? ""
        strength2 = snapshotValue["strength2"] as? String ?? ""
        weakness1 = snapshotValue["weakness1"] as? String ?? ""
        weakness2 = snapshotValue["weakness2"] as? String ?? ""
        //ref = snapshot.ref
    }

}
