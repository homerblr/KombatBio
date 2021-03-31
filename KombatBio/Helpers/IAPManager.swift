//
//  IAPManager.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 24.03.21.
//

import Foundation
import StoreKit


class IAPManager: NSObject {
    
    static let shared = IAPManager()
    
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    
    let userDefaultKey = "premium_purchased"
    
    func hideAds() {
        UserDefaults.standard.set(true, forKey: userDefaultKey)
    }
    
    func isPurchased() -> Bool {
        let purchaseStatus = UserDefaults.standard.bool(forKey: userDefaultKey)
        if purchaseStatus {
            return true
        } else {
            return false
        }
    }
    
    private override init() {}
    
    deinit {
        paymentQueue.remove(self)
    }
    
    public func setupPurchases(callback: @escaping(Bool)->()) {
        if SKPaymentQueue.canMakePayments(){
           paymentQueue.add(self)
            callback(true)
            return
        }
            callback(false)
    }
    
    public func getProducts() {
        let identifiers: Set = [IAPProducts.removeAds.rawValue]
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }
    
    public func purchase(purchaseWith identifier: String) {
        guard let product = products.filter({$0.productIdentifier == identifier}).first else {
            return
        }
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    public func restoreCompletedTransactions() {
        paymentQueue.restoreCompletedTransactions()
    }
    
}

extension IAPManager: SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            
            case .purchasing:
                break
            case .purchased:
                hideAds()
                completed(transaction: transaction)
            case .failed:
                failed(transaction: transaction)
            case .restored:
                hideAds()
                restored(transaction: transaction)
                print("restored")
            case .deferred:
                break
            @unknown default:
                print("error")
            }
        }
    }
    
    private func failed(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Transaction error \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func completed(transaction: SKPaymentTransaction) {
        paymentQueue.finishTransaction(transaction)
        NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationCompleted), object: nil)
    }
    private func restored(transaction: SKPaymentTransaction) {
        paymentQueue.finishTransaction(transaction)
        NotificationCenter.default.post(name: NSNotification.Name(Constants.notificationRestored), object: nil)
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("finished")
        if queue.transactions.count == 0 {
            print("no transactions")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("Found an error while restoring purchase: \(error)")
        if queue.transactions.count == 0 {
            print("no transactions")
        }
    }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        products.forEach {print($0.localizedTitle)}
        print("делегат сработал")
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("HERE IS YOUR ERROR \(error)")
    }
    
}
