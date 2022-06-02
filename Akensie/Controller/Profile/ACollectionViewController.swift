//
//  ACollectionViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 17/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

private let reuseIdentifier = "Cell"

class ACollectionViewController: UICollectionViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var achievementsData = [AchievementModel]()

    var achievementModelOne: AchievementModel?
    var achievementModelTwo: AchievementModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false



        // Do any additional setup after loading the view.
        retrieveAchiements()
        
//        retrieveUserAch()
    }
    
    func retrieveAchiements() {
        db.collection("allAchievements").addSnapshotListener() {(snapshot, error) in
            
            self.achievementsData = []
            if let err = error {
                print("Error retrieving Achievements: \(err.localizedDescription)")
            }else {
                if let qss = snapshot?.documents {
                    
                    for doc in qss {
     
                        self.achievementsData.append(AchievementModel(text: doc.data()["text"] as! String, image: doc.data()["image"] as! String, description: doc.data()["description"] as! String, points: doc.data()["points"] as! Int))

                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                    }
                }
            }
        }
        
        
    }
    
    func retrieveUserAch() {
        
        if let docID = defaults.string(forKey: "documentID") {
            
            db.collection("users").document(docID).collection("achievement manager").order(by: "date", descending: false).getDocuments { (snapShot, error) in
                
                if let err = error {
                    print("error retrieving achievement: \(err.localizedDescription)")
                }else {
                    if let qss = snapShot?.documents {
                        for doc in qss {
                            if let path = doc.data()["unlock"] as? DocumentReference {
                                path.getDocument { (snap, error) in
                                    
                                    if let err = error {
                                        print(err)
                                    }else {
                                        if let finalAch = snap?.data(){
                                            self.achievementsData.append(AchievementModel(text: finalAch["text"] as! String, image: finalAch["image"] as! String, description: finalAch["description"] as! String, points: finalAch["points"] as! Int))
                                            
                                           
                                            
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
    
    
    @IBAction func completeShowAll(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            retrieveAchiements()
        }else {
            retrieveUserAch()
        }
        self.achievementsData = []
        self.collectionView.reloadData()
        
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("ach count: \(achievementsData.count)")
        return achievementsData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)as! AllAchievementsCell
    
        // Configure the cell
        cell.achLabel.text = achievementsData[indexPath.row].text
//        cell.achImage.image = UIImage(named: achievementsData[indexPath.row].image)
        cell.achImage.image = UIImage(named: achievementsData[indexPath.row].image)
       
//        if let imageCached = cacheImage.object(forKey: achievementsData[indexPath.row].image as NSString) {
//            
//            cell.achImage.image = imageCached
//        
//        }else {
//            storage.reference(withPath: "Achievements/\(achievementsData[indexPath.row].image).png").getData(maxSize: 4 * 1024 * 1024) { [self] (data, error) in
//                if let err = error {
//                    print("error dowloading ach Image: \(err)")
//                }else {
//                    
//                    if data != nil {
//                        let downloadedImage = UIImage(data: data!)
//                        
//                        cacheImage.setObject(downloadedImage!, forKey: achievementsData[indexPath.row].image as NSString)
//                        loadImage()
//                    }else {
//                        print("count")
//                    }
//                    
//                }
//                
//            }
//        }
        
        func loadImage() {
            cell.achImage.image = cacheImage.object(forKey: achievementsData[indexPath.row].image as NSString)
        }
        
        
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: achievementsData[indexPath.row].text, message: achievementsData[indexPath.row].description, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    

}



extension ACollectionViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds

       let size = CGSize(width: bounds.width / 2 - 30, height: (bounds.width / 2 - 30) + 61)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
