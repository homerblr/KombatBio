//
//  AboutDevVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 18.03.21.
//

import UIKit
import SwiftyGif
import FirebaseCrashlytics

class AboutDevVC: UIViewController {
    @IBOutlet weak var mishaGif: UIImageView!
    @IBOutlet weak var mishaLinkedIn: UIButton!
    @IBOutlet weak var dashaGif: UIImageView!
    @IBOutlet weak var mishaEmail: UIButton!
    @IBOutlet weak var dashaLinkedIn: UIButton!
    @IBOutlet weak var dashaEmail: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mishaLinkedIn.layer.cornerRadius = 10
        mishaEmail.layer.cornerRadius = 10
        dashaLinkedIn.layer.cornerRadius = 10
        dashaEmail.layer.cornerRadius = 10
        let mishaGifToDisplay = try? UIImage(gifName: "Umk3s.gif")
        let dashaGifGifToDisplay = try? UIImage(gifName: "Kitana_UMK3.gif")
        mishaGif.setGifImage(mishaGifToDisplay!, manager: .defaultManager, loopCount: -1)
        dashaGif.setGifImage(dashaGifGifToDisplay!, manager: .defaultManager, loopCount: -1)
    }
    
    @IBAction func mishaLinkedInTapped(_ sender: UIButton) {
        let linkedInURL = URL(string:"https://www.linkedin.com/in/mkisly/")
        UIApplication.shared.open(linkedInURL!, options: [:], completionHandler: nil)
        
    }
    @IBAction func mishaEmailTapped(_ sender: UIButton) {
        let url = URL(string: "mailto:mikhail.kisly@gmail.com")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @IBAction func dashaLinkedInTapped(_ sender: UIButton) {
        let linkedInURL = URL(string:"https://www.linkedin.com/in/dkislaya/")
        UIApplication.shared.open(linkedInURL!, options: [:], completionHandler: nil)
        
    }
    @IBAction func dashaEmailTapped(_ sender: UIButton) {
        let url = URL(string: "mailto:dariana1902@gmail.com")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
}
