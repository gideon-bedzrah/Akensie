//
//  UserAchievements.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 17/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserAchievements {
    
    static func allAchievements(name: String) {
        
        if let docID = defaults.string(forKey: "documentID") {
            let db = Firestore.firestore()
            
            db.collection("users").document(docID).collection("achievement manager").document(name).setData(["unlock": db.collection("allAchievements").document(name),
                                                    "date": Date()])
        }
        
    }
    
    static func retrieveUserAch() {
        
        if let docID = defaults.string(forKey: "documentID") {
            let db = Firestore.firestore()
            
            db.collection("users").document(docID).collection("achievement manager").getDocuments { (snapShot, error) in
                if let err = error {
                    print("error retrieving achievement: \(err.localizedDescription)")
                }else {
                    if let qss = snapShot?.documents {
                        for doc in qss {
//                            print("new: \(doc.data()["unlock"]!) ")
                            let path = doc.data()["unlock"]! as! DocumentReference
                            path.getDocument { (snap, error) in
                                if let err = error {
                                    
                                }else {
                                    if let finalAch = snap?.data(){
                                        
                                    }
                                }
                            }
                            print("new: \(path)")
                        }
                    }
                }
            }
        }
    }

}


