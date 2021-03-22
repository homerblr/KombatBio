//
//  GoogleAds.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 22.03.21.
//

import UIKit
import GoogleMobileAds


class GoogleAds: NSObject, GADFullScreenContentDelegate {
    let adMobID = "ca-app-pub-3155855996937060/5631423799"
    let admobTestID = "ca-app-pub-3940256099942544/4411468910"
    
    var interstitialAD : GADInterstitialAd?
    
    func createAndShowAd(){
        
        interstitialAD?.fullScreenContentDelegate = self
        GADInterstitialAd.load(withAdUnitID: admobTestID, request: GADRequest()) { [weak self] (admobAd, error) in
            if let error = error {
                print(error)
            } else {
                self?.interstitialAD = admobAd
            }
        }
    }

}
