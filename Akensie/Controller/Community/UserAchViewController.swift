//
//  UserAchViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 24/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class UserAchViewController: UIViewController {

    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var achievementsData: [AchievementModel]?
    var docID: String?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noachlabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        retrieveUserAch()
        
    }
    
    func retrieveUserAch() {
        
        if let docID = self.docID {
            
            db.collection("users").document(docID).collection("achievement manager").order(by: "date", descending: false).getDocuments { [self] (snapShot, error) in
                
                if let err = error {
                    print("error retrieving achievement: \(err.localizedDescription)")
                }else {
                    if let qss = snapShot?.documents {
                        self.achievementsData = []
                        if qss.isEmpty {
                            noachlabel.isHidden = false
                            self.activityIndicator.isHidden = true
                        }
                        for doc in qss {
                            if let path = doc.data()["unlock"] as? DocumentReference {
                                path.getDocument { (snap, error) in
                                    if let err = error {
                                        print(err)
                                    }else {
                                        
                                        if let finalAch = snap?.data(){
                                            self.achievementsData?.append(AchievementModel(text: finalAch["text"] as! String, image: finalAch["image"] as! String, description: finalAch["description"] as! String, points: finalAch["points"] as! Int))
                                            print("hello: \(finalAch)")
                                            
                                            self.activityIndicator.isHidden = true
                                            
                                            DispatchQueue.main.async {
                                                self.collectionView.reloadData()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                       
                    }
                }
                
                
            }
        }
        
    }

}

extension UserAchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return achievementsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchCell", for: indexPath) as! AchieveCollectionViewCell
        
        
        if let achievements = achievementsData?[indexPath.row] {
            cell.achLabel.text = achievements.text
            cell.achImage.image = UIImage(named: achievements.image)
        }
        
        return cell
    }
    
    
}
