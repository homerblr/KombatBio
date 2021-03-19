//
//  AboutDevVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 18.03.21.
//

import UIKit
import SwiftyGif
import FirebaseCrashlytics
import FirebaseRemoteConfig

class AboutDevVC: UIViewController {
    @IBOutlet weak var mishaGif: UIImageView!
    @IBOutlet weak var mishaLinkedIn: UIButton!
    @IBOutlet weak var dashaGif: UIImageView!
    @IBOutlet weak var mishaEmail: UIButton!
    @IBOutlet weak var dashaLinkedIn: UIButton!
    @IBOutlet weak var dashaEmail: UIButton!
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        mishaLinkedIn.layer.cornerRadius = 10
        mishaEmail.layer.cornerRadius = 10
        dashaLinkedIn.layer.cornerRadius = 10
        dashaEmail.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remoteConfig.fetchAndActivate { [weak self] (status, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if status != .error {
                    if let mishaGifName = self?.remoteConfig["misha_gif_name"].stringValue, let dashaGifName = self?.remoteConfig["dasha_gif_name"].stringValue  {
                        let mishaGifToDisplay = try? UIImage(gifName: mishaGifName)
                        let dashaGifToDisplay = try? UIImage(gifName: dashaGifName)
                        DispatchQueue.main.async {
                            self?.mishaGif.setGifImage(mishaGifToDisplay!, manager: .defaultManager, loopCount: -1)
                            self?.dashaGif.setGifImage(dashaGifToDisplay!, manager: .defaultManager, loopCount: -1)
                        }
                    }
                }
                
            }
            
        }
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
