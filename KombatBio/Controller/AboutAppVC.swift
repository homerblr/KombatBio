//
//  AboutAppVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 18.03.21.
//

import UIKit
import FirebaseRemoteConfig

class AboutAppVC: UIViewController {
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        remoteConfig.fetchAndActivate { [weak self] (status, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if status != .error {
                    if let descriptionText = self?.remoteConfig["about_app_description"].stringValue  {
                        DispatchQueue.main.async {
                            self?.descriptionLabel.text = descriptionText
                        }
                    }
                }
                
            }
            
        }
    }
    
}
