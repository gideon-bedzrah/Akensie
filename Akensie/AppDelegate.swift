//
//  AppDelegate.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 08/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseMessaging

let defaults = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.Message_ID"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        application.applicationIconBadgeNumber = 0
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        
        //initialize Firebase
        FirebaseApp.configure()
        
//        if #available(iOS 10.0, *) {
//          // For iOS 10 display notification (sent via APNS)
//          UNUserNotificationCenter.current().delegate = self
//
//          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//          UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: {_, _ in })
//        } else {
//          let settings: UIUserNotificationSettings =
//          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//          application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self
        
        //initialize adMob
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
        
        if(application.applicationState == .inactive)
          {
            print("user tapped the notification bar when the app is in background")
          }
          
          /* Change root view controller to a specific viewcontroller */
          // let storyboard = UIStoryboard(name: "Main", bundle: nil)
          // let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerStoryboardID") as? ViewController
          // self.window?.rootViewController = vc

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        print("deviceToken: \(deviceTokenString)")
    }
    
    func uploadToken() {
       
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
        updateFirestorePushTokenIfNeeded()
        
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func updateFirestorePushTokenIfNeeded() {
        if let userID = defaults.string(forKey: "documentID") {
            if let token = Messaging.messaging().fcmToken {
                 Firestore.firestore()
                    .collection("users").document(userID).collection("notifications").document("notificationToken").setData(["fcmToken" : token])
            }
        }
    }
}

extension Data {
    
    var hexString: String {
        let hexString = map {String(format: "%02.2hhx", $0)}.joined()
        return hexString
    }
}

