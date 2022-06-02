//
//  SceneDelegate.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 08/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
let userDefaults = UserDefaults.standard
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        if userDefaults.bool(forKey: "isLoggedIn") {
        
        
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
            if user != nil {
                self.window?.rootViewController = storyboard.instantiateViewController(identifier: "WelcomeHome")
                self.window?.makeKeyAndVisible()
                
                GameScores.totalScore()
                
                if let user = Auth.auth().currentUser {
                    self.userDefaults.set(user.uid, forKey: "userID")
                    let db = Firestore.firestore()
                    db.collection("users").whereField("uid", isEqualTo: user.uid).addSnapshotListener{ (Snapshot, error) in
                        if let err = error {
                            print("Error getting user: \(err)")
                        }else {
                            for document in Snapshot!.documents {
//                                print("open: \(document.data())")
                                self.userDefaults.set(document.documentID, forKey: "documentID")
                                
                                if let retrievedname = document.data()["full name"] {
                                    self.userDefaults.set(retrievedname as? String, forKey: "full name")
                                }
                                if let retrieveTag = document.data()["username"]{
                                    self.userDefaults.set(retrieveTag as? String, forKey: "username")
                                }
                                if let retrieveScore = document.data()["score"]{
                                    self.userDefaults.set(retrieveScore as? Int, forKey: "score")
                                }
                                if let retrieveImage = document.data()["profilePic"]{
                                    self.userDefaults.set(retrieveImage as? String, forKey: "profilePic")

                                }
                            }
                        }
                    }
                    
                }
                
                
                
            }else {
                self.window?.rootViewController = storyboard.instantiateViewController(identifier: "SplashScreen")
                self.window?.makeKeyAndVisible()
                cacheImage.removeAllObjects()
            }
            
        }
        
//        }
        
    
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
         
    }


}

