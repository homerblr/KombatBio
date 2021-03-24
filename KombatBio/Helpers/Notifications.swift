//
//  Notifications.swift
//  KombatBio
//
//  Created by Mikhail Kisly on 22.03.21.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    func notificationRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("User has declined notification permisson")
            }
        }
    }
    
    func scheduleNotification(notificationType: String) {
        let content = UNMutableNotificationContent()
        let userActions = "MK Bio"
        content.title = notificationType
        content.body = "Polish your favorite fighter skill"
        //TODO: Remote config at local notification body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = userActions
        
        var calendarComponents = DateComponents()
        calendarComponents.weekday = 2
        calendarComponents.hour = 19
        calendarComponents.second = 0
        calendarComponents.minute = 0
        
        
        let weekdayTriger = UNCalendarNotificationTrigger(dateMatching: calendarComponents, repeats: true)
       
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: weekdayTriger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
   
    
}
