//
//  DetailScreenVM.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 11.03.21.
//

import UIKit
import Kingfisher


protocol IDetailScreenVM {
    func configureScreen(fighter: Characters?, fighterImage: UIImageView, fighterName: UILabel, fighterMotto: UILabel, fighterDescription: UILabel, fandomButton: UIButton)
}

class DetailScreenVM : IDetailScreenVM {
    
    func configureScreen(fighter: Characters?, fighterImage: UIImageView, fighterName: UILabel, fighterMotto: UILabel, fighterDescription: UILabel, fandomButton: UIButton) {
        if let selectedFighter = fighter, let imageURL = URL(string: selectedFighter.fullSizeImageURL) {
            fighterImage.kf.setImage(with: imageURL)
            fighterName.text = selectedFighter.name
            fighterMotto.text = selectedFighter.motto
            fighterDescription.text = selectedFighter.description
            fandomButton.layer.borderColor = UIColor.white.cgColor
            fandomButton.layer.borderWidth = 1
        }
    }

}
