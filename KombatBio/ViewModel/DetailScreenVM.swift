//
//  DetailScreenVM.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 11.03.21.
//

import UIKit
import Kingfisher



protocol DetailScreenVMProtocol {
    var fighter : Characters? {get}
    var fighterName: String? {get}
    var fighterMotto: String? {get}
    var fighterDescription: String? {get}
    var fighterImageURL: URL? {get}
    var fighterStrength1: String? {get}
    var fighterStrength2: String? {get}
    var fighterWeakness1: String? {get}
    var fighterWeakness2: String? {get}
}

class DetailScreenVM : DetailScreenVMProtocol {
    
    var fighter : Characters?
    var fighterName, fighterMotto, fighterDescription, fighterStrength1, fighterStrength2, fighterWeakness1, fighterWeakness2: String?
    var fighterImageURL: URL?
    
    init(fighter : Characters?) {
        self.fighter = fighter
        self.fighterName = fighter?.name
        self.fighterMotto = fighter?.motto
        self.fighterDescription = fighter?.description
        self.fighterImageURL = URL(string: fighter!.fullSizeImageURL)
        self.fighterStrength1 = fighter?.strength1
        self.fighterStrength2 = fighter?.strength2
        self.fighterWeakness1 = fighter?.weakness1
        self.fighterWeakness2 = fighter?.weakness2
    }
    
//    func configureScreen(fighterImage: UIImageView, fighterName: UILabel, fighterMotto: UILabel, fighterDescription: UILabel, fandomButton: UIButton) {
//        if let selectedFighter = fighter, let imageURL = URL(string: selectedFighter.fullSizeImageURL) {
//            fighterImage.kf.setImage(with: imageURL)
//            fighterName.text = selectedFighter.name
//            fighterMotto.text = selectedFighter.motto
//            fighterDescription.text = selectedFighter.description
//            fandomButton.layer.borderColor = UIColor.white.cgColor
//            fandomButton.layer.borderWidth = 1
//        }
//    }
    

}
