//
//  SettingsVC.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 17.03.21.
//

import UIKit
import StoreKit

class SettingsVC: UIViewController {
     
    private var purchaseModel = [SKProduct]()
    
    private let cellID = "settingsCell"
    
    
    let model = ["Remove ads","Restore purchase","Rate app","About app","About developer", "Share App"]

    let story = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        fetchProducts()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.standardAppearance.titlePositionAdjustment = UIOffset(horizontal: -110, vertical: 0)
    }
}


extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToSelected(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
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
            if SKPaymentQueue.canMakePayments() {
                let payment = SKPayment(product: purchaseModel[row])
                SKPaymentQueue.default().add(payment)
            }
        case 1:
            SKPaymentQueue.default().add(self)
              SKPaymentQueue.default().restoreCompletedTransactions()
        case 2:
            print("case2")
            //selectedVC = story.instantiateViewController(identifier: storyBoardID.rateApp.rawValue)
        case 3:
            selectedVC = story.instantiateViewController(identifier: storyBoardID.aboutApp.rawValue)
            navigationController?.pushViewController(selectedVC, animated: true)
        case 4:
            selectedVC = story.instantiateViewController(identifier: storyBoardID.aboutDev.rawValue)
            navigationController?.pushViewController(selectedVC, animated: true)
        case 5:
            shareApp()
        default:
            break
        }
    }
}

extension SettingsVC: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        purchaseModel = response.products
    }
    
    private func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: ["com.temporary.id"])
        request.delegate = self
        request.start()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                //SKPaymentQueue.default().remove(self)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .restored:
                if SKPaymentQueue.canMakePayments() {
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
                //SKPaymentQueue.default().remove(self)
                print("restored")
            case .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            @unknown default:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transaction restored")
        showAlertRestore(title: "Purchase restored", message: "Your purchase was successfuly restored")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("error restoring transaction: \(error)")
        if queue.transactions.count == 0 {
            showAlertRestore(title: "Oops", message: "There are no purchases to restore, please buy one")
        }
        showAlertRestore(title: "Failed at restoring purchase", message: "There was an error restoring your purchase, please try again")
    }
    
    
    func showAlertRestore(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
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
}
