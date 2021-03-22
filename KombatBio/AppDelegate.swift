//
//  AppDelegate.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 23.02.21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let notifications = Notifications()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        notifications.notificationCenter.delegate = self
        notifications.notificationRequest()
        notifications.scheduleNotification(notificationType: "Finish him!")
    
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        //standard.backgroundColor = .navBarColor
        standard.titlePositionAdjustment = UIOffset(horizontal: -110, vertical: 0)
        standard.titleTextAttributes = [.foregroundColor: UIColor.charactersColor, .font: UIFont(name: "MortalKombat-Regular", size: 20)]
        UINavigationBar.appearance().standardAppearance = standard
        
        let finishersAppereance = UINavigationBarAppearance()
        finishersAppereance.configureWithOpaqueBackground()
        //finishersAppereance.backgroundColor = .navBarTintColor
        //navBarDetailTint
        finishersAppereance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        finishersAppereance.titleTextAttributes = [.foregroundColor: UIColor.charactersColor, .font: UIFont(name: "MortalKombat-Regular", size: 20)]
        UINavigationBar.appearance().compactAppearance = finishersAppereance
        
        
//        let settingsAppereance = UINavigationBarAppearance()
//        settingsAppereance.configureWithOpaqueBackground()
//        //finishersAppereance.backgroundColor = .navBarTintColor
//        //navBarDetailTint
//        settingsAppereance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
//        settingsAppereance.titleTextAttributes = [.foregroundColor: UIColor.charactersColor, .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 16)]
//        UINavigationBar.appearance().standardAppearance = settingsAppereance
        
        FirebaseApp.configure()
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

