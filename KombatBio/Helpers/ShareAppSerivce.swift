//
//  ShareAppSerivce.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 31.03.21.
//

import UIKit

class ShareAppSerivce {
    static let shared = ShareAppSerivce()
    private init() {}
    
    func shareApp(VC: UIViewController) {
        if let urlStr = NSURL(string: Constants.shareAppStoreURL) {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = VC.view
                    popup.sourceRect = CGRect(x: VC.view.frame.size.width / 2, y: VC.view.frame.size.height / 4, width: 0, height: 0)
                }
            }
            VC.present(activityVC, animated: true, completion: nil)
        }
    }
}
