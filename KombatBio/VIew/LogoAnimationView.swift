//
//  LogoAnimationView.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 5.03.21.
//

import UIKit
import SwiftyGif

class LogoAnimationView: UIView {

    let logoGifImageView = try! UIImageView(gifImage: UIImage(gifName: "raidenGif.gif"), loopCount: 3)

       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }

       private func commonInit() {
        backgroundColor = UIColor.splashBackgroundColor
           addSubview(logoGifImageView)
           logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
           logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
           logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//           logoGifImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
//           logoGifImageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
       }
}
