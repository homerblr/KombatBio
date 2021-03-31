//
//  ReviewService.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 31.03.21.
//

import Foundation
import StoreKit


class ReviewService {
   static let shared = ReviewService()
    
    private init() {}
    
    func requestReview() {
        if #available(iOS 14.0, *) {
               if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                   SKStoreReviewController.requestReview(in: scene)
               }
           } else if #available(iOS 10.3, *) {
               SKStoreReviewController.requestReview()
           }
    }
}
