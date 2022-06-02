//
//  ProfileViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 19/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseFirestore

let cacheImage = NSCache<NSString, UIImage>()
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var leaderboardView: UIView!
    @IBOutlet weak var leaderboardText: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var noAchievementsLabel: UILabel!
    
    
    let userDefaults = UserDefaults.standard
    let db = Firestore.firestore()
    let storage = Storage.storage()
    

    
    var ranking = [LeaderboardModel]()

    var achievementsData: [AchievementModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //check if score is 3000
        if defaults.string(forKey: "documentID") != nil {
            GameScores.totalScore()
        }
        
        if userDefaults.integer(forKey: "score") == 3000 {
            let alert = UIAlertController(title: "🎉 New achievement unlocked!", message: "You're on a roll has now been unlocked. You earned 3000xp.", preferredStyle: .alert)
            
            UserAchievements.allAchievements(name: "threeXP")
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {_ in
                self.collectionView.reloadData()
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
       
       
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        tableView.dataSource = self
        leaderboardView.layer.cornerRadius = 10
        tableView.rowHeight = 80
        tableView.layer.cornerRadius = 10
        
        
        if let fullName = userDefaults.string(forKey: "full name") {
            self.fullName.text = fullName
        }
        
        if let userName = userDefaults.string(forKey: "username") {
            self.userName.text = userName
        }
        
        pointsLabel.text = "\(userDefaults.integer(forKey: "score"))"
        
        retrieveLeaderboard()
        retrieveUserAch()
        //MARK: - retrieving profile image
        
        //checking if image is already saved in cache, if not we download it
        

        if let imageCached = cacheImage.object(forKey: NSString(string: "userProfilePic")) {
                self.profileImage.image = imageCached

            print("Using cached image")
        } else {
            if let user = Auth.auth().currentUser?.uid {
                    storage.reference(withPath: "ProfileImage/\(user).jpeg").getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                        var downloadedImage: UIImage?

                            if let err = error {
                                print("error uploading data: \(err)")
                            }else {
                                if let d = data {
                                    downloadedImage = UIImage(data: d)
                                    if downloadedImage != nil {
                                        print("redownloading image")
                                        cacheImage.setObject(downloadedImage!, forKey: NSString(string: "userProfilePic"))
                                        DispatchQueue.main.async {
                                            self.profileImage.image = downloadedImage
                                        }
                                    }

                                }
                            }
                        }
                }
        }
        
    }
    
    
    
    //MARK: - retrieving leaderboard
    func retrieveLeaderboard() {
        db.collection("users").order(by: "score", descending: true).addSnapshotListener { (snapshot, error) in
            
            self.ranking = []
            if let err = error {
                print("error loading leaderboard: \(err.localizedDescription)")
            } else {
                if let qss = snapshot?.documents {
                    for doc in qss {
                        
                        if let retrievedName = doc.data()["full name"] as? String, let retrievedScore = doc.data()["score"] as? Int, let retrievedUsername = doc.data()["username"] as? String, let retrievedPic = doc.data()["profilePic"] as? String{
                            DispatchQueue.main.async {
                                
                                self.ranking.append(LeaderboardModel(name: retrievedName, username: retrievedUsername, score: retrievedScore, pic: retrievedPic, docId: doc.documentID, position: 0))
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: - logging out
    @IBAction func logoutTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let logoutAction = UIAlertAction(title: "Yes", style: .default) { (logout) in
                cacheImage.removeObject(forKey: "userProfilePic")
                cacheImage.removeAllObjects()
            defaults.removeObject(forKey: "full name")
            defaults.removeObject(forKey: "score")
                let firebaseAuth = Auth.auth()
                
                do {
                  try firebaseAuth.signOut()
//                    self.userDefaults.set(false, forKey: "isLoggedIn")
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
        }
        
        
        alert.addAction(logoutAction)
        self.present(alert, animated: true, completion: nil)
    
        
    }
    
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
   //MARK: - Edit profile picture
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        print("edit tapped")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Select a new profile image", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        let action = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            print("presenting picker controller")
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
//        let actionCamera = UIAlertAction(title: "Use camera", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        
        actionSheet.addAction(action)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let imageToUpload: UIImage
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
             profileImage.image = editedImage
//            imageToUpload = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileImage.image = originalImage
        }
        
        if let imageToUplaod = profileImage.image?.jpegData(compressionQuality: 0.75){
            uploadImage(imageToUplaod)
            if profileImage.image != nil {
                cacheImage.setObject(profileImage.image!, forKey: NSString(string: "userProfilePic"))
            }
        }
        
      
        
        // save image to firebase
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - Uploading Profile pic
    func uploadImage(_ imageData: Data) {

        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"

        if let user = Auth.auth().currentUser?.uid {
            storage.reference(withPath: "ProfileImage/\(user).jpeg").putData(imageData, metadata: uploadMetadata) { (downloadMeta, error) in
                if let err = error {
                    print("Error uploading image: \(err.localizedDescription)")
                }else {
                    print("image upload successfull!: \(String(describing: downloadMeta))")
                    if let meta = downloadMeta?.name{
                        if let docID = self.userDefaults.string(forKey: "documentID") {
                            self.db.collection("users").document("\(docID)").updateData(["profilePic" : meta]){ err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                    
                                    let alert = UIAlertController(title: "🎉 New achievement unlocked!", message: "Shiny New Look has now been unlocked. You set a new profile image.", preferredStyle: .alert)
                                    
                                    UserAchievements.allAchievements(name: "newProfile")
                                    
                                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                                    
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                    
                    
                }
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}


//MARK: - leaderboard table

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return ranking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! LeaderboardTableViewCell
            let rankIndex = ranking[indexPath.row]
            cell.fullName.text = rankIndex.name
            cell.pointsLabel.text = "\(rankIndex.score) xp"
            cell.userName.text = rankIndex.username
            cell.position = indexPath.row + 1
            cell.iconView.loadMetaImage(from: rankIndex.pic)
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! LeaderboardTableViewCell
            let rankIndex = ranking[indexPath.row]
            
            cell.fullName.text = rankIndex.name
            cell.pointsLabel.text = "\(rankIndex.score) xp"
            cell.userName.text = rankIndex.username
            cell.position = indexPath.row + 1
            cell.iconView.loadMetaImage(from: rankIndex.pic)
            
            return cell
        }
        
    }
    
    
}

//MARK: - Achievements

extension ProfileViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievementsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchievementsCell
        
        if let achievements = achievementsData?[indexPath.row] {
            cell.achLabel.text = achievements.text
            cell.achImage.image = UIImage(named: achievements.image)
        }
        
        return cell
    }
    
    func retrieveUserAch() {
        
        if let docID = defaults.string(forKey: "documentID") {
            
            db.collection("users").document(docID).collection("achievement manager").order(by: "date", descending: false).getDocuments { (snapShot, error) in
                
                if let err = error {
                    print("error retrieving achievement: \(err.localizedDescription)")
                }else {
                    if let qss = snapShot?.documents {
                        self.achievementsData = []
                        
                        if qss.isEmpty {
                            self.noAchievementsLabel.isHidden = false
//                            self.activityIndicator.isHidden = true
                        }
                        
                        for doc in qss {
                            if let path = doc.data()["unlock"] as? DocumentReference {
                                path.getDocument { (snap, error) in
                                    
                                    if let err = error {
                                        print(err)
                                    }else {
                                        if let finalAch = snap?.data(){
                                            self.achievementsData?.append(AchievementModel(text: finalAch["text"] as! String, image: finalAch["image"] as! String, description: finalAch["description"] as! String, points: finalAch["points"] as! Int))
//                                            print("hello: \(finalAch)")
                                            
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

