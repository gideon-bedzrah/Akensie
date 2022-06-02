//
//  SettingsViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 16/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SettingsViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    let userSettings = [
        UserSettings(settingsLabel: "Vibrations and Haptics", settingsSubLabel: "Provides a unique haptic feedback after you answer a question either wrong or right", state: defaults.bool(forKey: "Haptics"), defaultName: "Haptics"),
        
        UserSettings(settingsLabel: "Alerts and Sound", settingsSubLabel: "Provides a uniques sound for completing a module and answering a question", state: defaults.bool(forKey: "Sound"), defaultName: "Sound"),
        
        UserSettings(settingsLabel: "Ambient Music", settingsSubLabel: "Sets the mood with some classic Ghanaian music", state: defaults.bool(forKey: "Music"), defaultName: "Music"),
        
//        UserSettings(settingsLabel: "Show Leaderboard", settingsSubLabel: "Determines whether or not the leaderboard is shown", state: defaults.bool(forKey: "Position"), defaultName: "Position"),
        
        UserSettings(settingsLabel: "Akan Mode", settingsSubLabel: "Changes the home screen texts into the Twi language [Relaunch app for full effect].", state: defaults.bool(forKey: "Akan"), defaultName: "Akan")
    ]

    let userWelcome = [
        
        UserSettings(settingsLabel: "Hide Welcome Prompt", settingsSubLabel: "Shows or hides Akensie 2.0 prompt when app is launched", state: defaults.bool(forKey: "Welcome"), defaultName: "Welcome")
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GameScores.totalScore()
       
    }
    
    
}

//ToEditProfile

extension SettingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }
        else {
            return userSettings.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell?
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileCell", for: indexPath) as! EditProfileCell
            
            if Auth.auth().currentUser != nil {
            (cell as! EditProfileCell).fullNameLabel.text = defaults.string(forKey: "full name")
                if let docID = defaults.string(forKey: "documentID") {
                    
                    // Get History Score
                    db.collection("users").document(docID).addSnapshotListener { (doc, error) in
                        if let err = error {
                            print("retrieving score unsuccessfull: \(err)")
                        } else {
                            if let d = doc?.data() {
                               print(d["full name"] as! String)
                                (cell as! EditProfileCell).fullNameLabel.text = d["full name"] as? String
                            }
                        }
                }
            }
            }else {
                (cell as! EditProfileCell).fullNameLabel.text = "Sign-In Required"
            }
            
            
            
            
            
//            (cell as! EditProfileCell).profileImage.image =
        }else if indexPath.section == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "ToggleSettings", for: indexPath) as! ToggleSettingsCell
            
            cell?.selectionStyle = .none
            
            (cell as! ToggleSettingsCell).settingsLabel.text = userWelcome[indexPath.row].settingsLabel
            
            (cell as! ToggleSettingsCell).settingsSubLabel.text = userWelcome[indexPath.row].settingsSubLabel
            
            (cell as! ToggleSettingsCell).state = userWelcome[indexPath.row].state
            
            (cell as! ToggleSettingsCell).defaultname = userWelcome[indexPath.row].defaultName
            
        }
        
        
        else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "ToggleSettings", for: indexPath) as! ToggleSettingsCell
            
            cell?.selectionStyle = .none
    
            
            (cell as! ToggleSettingsCell).settingsLabel.text = userSettings[indexPath.row].settingsLabel
            
            (cell as! ToggleSettingsCell).settingsSubLabel.text = userSettings[indexPath.row].settingsSubLabel
            
            (cell as! ToggleSettingsCell).state = userSettings[indexPath.row].state
            
            (cell as! ToggleSettingsCell).defaultname = userSettings[indexPath.row].defaultName
            
            
        }
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if Auth.auth().currentUser != nil {
                    performSegue(withIdentifier: "toProfile", sender: self)
                }else{
                    let alert = UIAlertController(title: "User profile", message: "Access your profile and achievements", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    alert.addAction(UIAlertAction(title: "Sign-In", style: .default, handler: { [self] (_) in
                        
                        cacheImage.removeAllObjects()
                        
                        let hVC = self.storyboard?.instantiateViewController(identifier: "SplashScreen")
                        self.view.window?.rootViewController = hVC
                        self.view.window?.makeKeyAndVisible()
                        
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            let destinationVC = segue.destination as! UserDetailsViewController
            destinationVC.docID = defaults.string(forKey: "documentID")
            destinationVC.retrievedName = defaults.string(forKey: "full name")
            destinationVC.retrievedUsername = defaults.string(forKey: "username")
            destinationVC.retrievedScore = String(defaults.integer(forKey: "score"))
            destinationVC.userDetails = "This is Akensie's source code baby"
        }
    }
    
    
    
    
    
}
