//
//  SettingsVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 17.03.21.
//

import UIKit
import StoreKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellID = "settingsCell"
    
    var modelForTableView = ["Remove ads","Restore purchase","Rate app","About app","About developer", "Share App"]

    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertPurchased), name: NSNotification.Name(rawValue: Constants.notificationCompleted), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertRestored), name: NSNotification.Name(rawValue: Constants.notificationRestored), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: -110, vertical: 0)
    }
}


extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = modelForTableView[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToSelected(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    @objc func showAlertPurchased() {
        let alert = UIAlertController(title: "Your purchase completed", message: "Thanks for your purchase, advertisements disabled", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showAlertRestored() {
        let alert = UIAlertController(title: "Your purchase was restored", message: "Your purchase was successfuly restored, enjoy!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func shareApp() {
        if let urlStr = NSURL(string: Constants.shareAppStoreURL) {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }
            self.present(activityVC, animated: true, completion: nil)
        }
    }

    
    enum storyBoardID: String {
        case aboutDev
        case aboutApp
        case rateApp
        case removeAds
        case restorePurchase
    }
    
    func goToSelected(indexPath row: Int) {
        var selectedVC = UIViewController()
        switch row {
        case 0:
            IAPManager.shared.purchase(purchaseWith: IAPProducts.testConsumable.rawValue)
        case 1:
            IAPManager.shared.restoreCompletedTransactions()
        case 2:
            print("rate app")
            //selectedVC = story.instantiateViewController(identifier: storyBoardID.rateApp.rawValue)
        case 3:
            selectedVC = storyBoard.instantiateViewController(identifier: storyBoardID.aboutApp.rawValue)
            navigationController?.pushViewController(selectedVC, animated: true)
        case 4:
            selectedVC = storyBoard.instantiateViewController(identifier: storyBoardID.aboutDev.rawValue)
            navigationController?.pushViewController(selectedVC, animated: true)
        case 5:
            shareApp()
        default:
            break
        }
    }
}
