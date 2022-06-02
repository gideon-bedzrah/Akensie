//
//  GameScores.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 25/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore


struct GameScores {
  
    let userDefaults = UserDefaults.standard
    
    static func newScore(dociD: String, category: String) {
        
        let db = Firestore.firestore()
        db.collection("users").document(dociD).collection("scoreManager").document(category).setData(
            ["easy" : 0,
             "medium": 0,
             "hard": 0]) {err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
        }
        
    }
    
    
   static func newBonus(dociD: String) {
        let db = Firestore.firestore()
        db.collection("users").document(dociD).collection("scoreManager").document("Bonus").setData(["bonus" : 0]){error in
            if let err = error {
                print("Error initializing bonus document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
        }
    }
    
    static func updateBonus(bonusScore: Int) {
         let userDefaults = UserDefaults.standard
        let db = Firestore.firestore()
        if let docID = userDefaults.string(forKey: "documentID"){
            db.collection("users").document(docID).collection("scoreManager").document("Bonus").updateData(["bonus": bonusScore]){ (error) in
                if let err = error {
                    print("Error saving bonus: \(err)")
                } else {
                    print("Score saved successfully!")
                }
            }
        }
        
    }
        
    static func updateScore(category: String, difficulty: String, score: Int) {
    
        let userDefaults = UserDefaults.standard
        
        
        let db = Firestore.firestore()
       if let docID = userDefaults.string(forKey: "documentID"){
        db.collection("users").document(docID).collection("scoreManager").document(category).updateData([difficulty : score]) { (error) in
            if let err = error {
                print("Error saving Score: \(err)")
            } else {
                print("Score saved successfully!")
            }
        }
        }
       
    }
    
    
   static func totalScore() {
        let userDefaults = UserDefaults.standard
        let db = Firestore.firestore()
        if let docID = userDefaults.string(forKey: "documentID"){
            
            // Get History Score
            db.collection("users").document(docID).collection("scoreManager").document(Constants.categories.history).addSnapshotListener({ (snapshot, error) in
                if let err = error {
                    print("retrieving score unsuccessfull: \(err)")
                } else {
                    userDefaults.set(snapshot?.get("easy") as! Int, forKey: Constants.History.easyScore)
                    userDefaults.set(snapshot?.get("medium") as! Int, forKey: Constants.History.mediumScore)
                    userDefaults.set(snapshot?.get("hard") as! Int, forKey: Constants.History.hardScore)
                }
            })
                                                                                                                                         
            // Get Art Score
                db.collection("users").document(docID).collection("scoreManager").document(Constants.categories.art).addSnapshotListener({ (snapshot, error) in
                        if let err = error {
                            print("retrieving score unsuccessfull: \(err)")
                        } else {
                            userDefaults.set(snapshot?.get("easy") as! Int, forKey: Constants.Art.easyScore)
                            userDefaults.set(snapshot?.get("medium") as! Int, forKey: Constants.Art.mediumScore)
                            userDefaults.set(snapshot?.get("hard") as! Int, forKey: Constants.Art.hardScore)
                        }
                    }
            
            )
            //Get General Score
            db.collection("users").document(docID).collection("scoreManager").document(Constants.categories.general).addSnapshotListener({ (snapshot, error) in
                               if let err = error {
                                   print("retrieving score unsuccessfull: \(err)")
                               } else {
                                   userDefaults.set(snapshot?.get("easy") as! Int, forKey: Constants.General.easyScore)
                                   userDefaults.set(snapshot?.get("medium") as! Int, forKey: Constants.General.mediumScore)
                                   userDefaults.set(snapshot?.get("hard") as! Int, forKey: Constants.General.hardScore)
                               }
                           }
                   
                   )
            
            // Get Business Score
            db.collection("users").document(docID).collection("scoreManager").document(Constants.categories.business).addSnapshotListener({ (snapshot, error) in
                        if let err = error {
                            print("retrieving score unsuccessfull: \(err)")
                        } else {
                            userDefaults.set(snapshot?.get("easy") as! Int, forKey: Constants.Business.easyScore)
                            userDefaults.set(snapshot?.get("medium") as! Int, forKey: Constants.Business.mediumScore)
                            userDefaults.set(snapshot?.get("hard") as! Int, forKey: Constants.Business.hardScore)
                        }
                    }
            
            )
            // Get Twitter Score
            db.collection("users").document(docID).collection("scoreManager").document(Constants.categories.popCulture).addSnapshotListener({ (snapshot, error) in
                        if let err = error {
                            print("retrieving score unsuccessfull: \(err)")
                        } else {
                            userDefaults.set(snapshot?.get("easy") as! Int, forKey: Constants.PopCulture.easyScore)
                            userDefaults.set(snapshot?.get("medium") as! Int, forKey: Constants.PopCulture.mediumScore)
                            userDefaults.set(snapshot?.get("hard") as! Int, forKey: Constants.PopCulture.hardScore)
                        }
                    }
            
            )
            
            // Get technology Score
            db.collection("users").document(docID).collection("scoreManager").document(Constants.categories.technology).addSnapshotListener({ (snapshot, error) in
                        if let err = error {
                            print("retrieving score unsuccessfull: \(err)")
                        } else {
                            userDefaults.set(snapshot?.get("easy") as! Int, forKey: Constants.Technology.easyScore)
                            userDefaults.set(snapshot?.get("medium") as! Int, forKey: Constants.Technology.mediumScore)
                            userDefaults.set(snapshot?.get("hard") as! Int, forKey: Constants.Technology.hardScore)
                        }
                    }
            
            )
            //Get bonus score
            db.collection("users").document(docID).collection("scoreManager").document("Bonus").addSnapshotListener { (snapShot, error) in
                if let err = error {
                    print("error retrieving bonus\(err)")
                }else {
                    userDefaults.set(snapShot?.get("bonus") as! Int, forKey: "firstBonus")
                }
            }
           
            // Tally of Scores
            let historyTotal = userDefaults.integer(forKey: Constants.History.easyScore) + userDefaults.integer(forKey: Constants.History.mediumScore) + userDefaults.integer(forKey: Constants.History.hardScore)
            
            let artTotal = userDefaults.integer(forKey: Constants.Art.easyScore) + userDefaults.integer(forKey: Constants.Art.mediumScore) + userDefaults.integer(forKey: Constants.Art.hardScore)
            
            let generalTotal = userDefaults.integer(forKey: Constants.General.easyScore) + userDefaults.integer(forKey: Constants.General.mediumScore) + userDefaults.integer(forKey: Constants.General.hardScore)
            
            let businessTotal = userDefaults.integer(forKey: Constants.Business.easyScore) + userDefaults.integer(forKey: Constants.Business.mediumScore) + userDefaults.integer(forKey: Constants.Business.hardScore)
            
            let twitterTotal = userDefaults.integer(forKey: Constants.PopCulture.easyScore) + userDefaults.integer(forKey: Constants.PopCulture.mediumScore) + userDefaults.integer(forKey: Constants.PopCulture.hardScore)
            
            let technologyTotal = userDefaults.integer(forKey: Constants.Technology.easyScore) + userDefaults.integer(forKey: Constants.Technology.mediumScore) + userDefaults.integer(forKey: Constants.Technology.hardScore)
            
            let bonusTotal = userDefaults.integer(forKey: "firstBonus")
            
            let totalScore = historyTotal + artTotal + generalTotal + businessTotal + twitterTotal + technologyTotal + bonusTotal
            
//            userDefaults.set(totalScore, forKey: "score")
            
            db.collection("users").document(docID).collection("scores").document("Akensie Categories").setData(["GameScore" : totalScore]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
            
        }
        
    }
    
    static func calculateScore() {
        guard let docID = defaults.string(forKey: "documentID") else {return}
        let db = Firestore.firestore()
        db.collection("users").document(docID).collection("scores").getDocuments{ (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            }else {
                if let doc = snapshot?.documents {
                    var accumulatedScore: Int = 0
                    for d in doc {
                       accumulatedScore += d.data()["GameScore"] as! Int
                    }
                    print(accumulatedScore)
                }
                
               
            }
            
        }
    }
    
}
