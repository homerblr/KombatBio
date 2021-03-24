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
        
        let defaults : [String: NSObject] = ["misha_gif_name": "shaokanGif.gif" as NSObject]
        
        remoteConfig.setDefaults(defaults)
        
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
        mishaGif.setGifImage(try! UIImage(gifName: "shaokanGif.gif"), manager: .defaultManager, loopCount: -1)
        dashaGif.setGifImage(try! UIImage(gifName: "Kitana_UMK3.gif"), manager: .defaultManager, loopCount: -1)
        
        remoteConfig.fetch(withExpirationDuration: 86400) { [weak self] (status, error) in
            if status == .success && error == nil {
                self?.remoteConfig.activate { [weak self] (activate, error) in
                    guard error == nil else {return}
                    let mishaValue = self?.remoteConfig.configValue(forKey: "misha_gif_name").stringValue
                    let dashaValue = self?.remoteConfig.configValue(forKey: "dasha_gif_name").stringValue
                    let mishaGifToDisplay = try? UIImage(gifName: mishaValue ?? "shaokanGif.gif")
                    let dashaGifToDisplay = try? UIImage(gifName: dashaValue ?? "shaokanGif.gif")
                    DispatchQueue.main.async {
                        self?.mishaGif.setGifImage(mishaGifToDisplay!, manager: .defaultManager, loopCount: -1)
                        self?.dashaGif.setGifImage(dashaGifToDisplay!, manager: .defaultManager, loopCount: -1)
                    }
                }
                
            }
        }
    }
    
    @IBAction func mishaLinkedInTapped(_ sender: UIButton) {
        let linkedInURL = URL(string: Constants.myLinkedInURL)
        UIApplication.shared.open(linkedInURL!, options: [:], completionHandler: nil)
        
    }
    @IBAction func mishaEmailTapped(_ sender: UIButton) {
        let url = URL(string: Constants.myEmail)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @IBAction func dashaLinkedInTapped(_ sender: UIButton) {
        let linkedInURL = URL(string: Constants.dashaLinkedInURL)
        UIApplication.shared.open(linkedInURL!, options: [:], completionHandler: nil)
        
    }
    @IBAction func dashaEmailTapped(_ sender: UIButton) {
        let url = URL(string: Constants.dashaEmail)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
}
