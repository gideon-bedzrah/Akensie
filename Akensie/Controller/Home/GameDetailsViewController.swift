//
//  GameDetailsViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 06/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation

class GameDetailsViewController: UIViewController, setBackbackground {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    
    @IBOutlet weak var numberOfQuestions: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var plays: UILabel!
    @IBOutlet weak var postImage: UIImageView!
//    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var playNow: UIButton!
    @IBOutlet weak var playedNotPlayed: UILabel!
    @IBOutlet weak var playedNotPlayedImage: UIImageView!
    @IBOutlet weak var playOnceLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    var player2: AVAudioPlayer!
    
//    let generator = UINotificationFeedbackGenerator()
    let db = Firestore.firestore()
    
    var color: UIColor?
    var post: NewPosts?
    var user: Users?
   let userID = defaults.string(forKey: "documentID")
    var posts = [NewPosts]()
    var playsToSend: Int?
    var likesToSend: Int?
    var playOnceToSend: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if collectionView != nil {
        collectionView.dataSource = self
        collectionView.delegate = self
        }
        
        self.playNow.isEnabled = false
        
        if profileButton != nil {
            profileButton.isEnabled = false
        }
        
        self.likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .selected)
        self.likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        UIImageView.changeDelegate = self
        
        if let p = post {
            fullnameLabel.text = p.userfullname
            usernameLabel.text = p.userUsername
            postTitle.text = p.title
            postCaption.text = p.caption
            numberOfQuestions.text = "\(p.questions.count) Questions"
            timeStamp.text = p.time.timeAgoDisplay()
            likes.text = "\(p.likesCount) Likes"
            likesCount()
            retrieveUser()
            playsCount()
            plays.text = "\(p.playsCount) Plays"
            playOnceToSend = p.playOnce
            if !p.playOnce{playNow.isEnabled = true} else {playOnceLabel.isHidden = false}
            if let url = URL(string: p.image){
                postImage.loadImage(from: url)
            }
            
            if postImage.image == UIImage(named: "NoLoadScreen") {
                playNow.isEnabled = false
                playNow.backgroundColor = .secondaryLabel
            }else {
                playNow.backgroundColor = UIColor(averageColorFrom: postImage.image)
                color = UIColor(averageColorFrom: postImage.image)
            }
            
            
          
            if !collectionView.isHidden {
                retrieveRecommendedGames()
            }
        }
//        if playNow.backgroundColor?.hashValue == 0 {
//            playNow.isEnabled = false
//        }
        
        
    }
    
    func changeColor() {
        DispatchQueue.main.async { [self] in
            if postImage.image != UIImage(named: "NoLoadScreen") {
        playNow.backgroundColor = UIColor(averageColorFrom: postImage.image)
            color = UIColor(averageColorFrom: postImage.image)
            }
//            if ((self.post?.playOnce) != nil) == true && self.playedNotPlayed.text == "Played" {
//                self.playNow.isEnabled = false
//                self.playNow.setTitle("Already Played", for: .disabled)
//
//            }else{
//                playNow.isEnabled = true
//            }
        }
    }
    
    
    func retrieveRecommendedGames() {
        
        db.collection("posts").whereField("postID", isNotEqualTo: post?.postID ?? "").getDocuments { [self] (snapshot, error) in
            
            self.posts = []
            if let err = error {
                print("error: \(err.localizedDescription)")
            }else {
            
                if let snap = snapshot?.documents{
                    for doc in snap {
                        
                        let result = Result {
                            try doc.data(as: NewPosts.self)
                           }
                           switch result {
                           case .success(let posts):
                            
                               if let posts = posts {
                                print("some: \(posts)")
                                self.posts.append(NewPosts(title: posts.title, caption: posts.caption, time: posts.time, image: posts.image, posterID: posts.posterID, likesCount: posts.likesCount, postID: posts.postID, playsCount: posts.playsCount, userfullname: posts.userfullname, userUsername: posts.userUsername, playOnce: posts.playOnce, questions: posts.questions))
                                
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            
                               } else {
                                   print("Document does not exist")
                               }
                           case .failure(let error):
                        
                               print("Error decoding city: \(error)")
                           }
                        
                    }
                    posts.shuffle()
                }
            }
        }
    }
    
    func likesCount() {
        db.collection("posts").document(post!.postID).collection("likes").addSnapshotListener { (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot {
                    self.likesToSend = snap.count
                    if snap.count == 1 {
                        self.likes.text = "\(snap.count) Like"
                    }else {
                        self.likes.text = "\(snap.count) Likes"
                    }
                    
                    for s in snap.documents {
                        if s.documentID == self.userID {
                            self.likeButton.isSelected = true
                            
                        }
                    }
                }
            }
        }
    }
    
    func playsCount() {
        db.collection("posts").document(post!.postID).collection("plays").addSnapshotListener { (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot {
                    self.playsToSend = snap.count
                    if snap.count == 1 {
                        self.plays.text = "\(snap.count) Play"
                        
                    }else {
                        self.plays.text = "\(snap.count) Plays"
                    }
                    
                    for s in snap.documents {
                        if s.documentID == self.userID {
                            self.playedNotPlayed.text = "Played"
                            self.playedNotPlayedImage.image = UIImage(systemName: "checkmark")
                            if self.post!.playOnce == true {
                                self.playNow.isEnabled = false
                                self.playNow.setTitle("Already Played", for: .disabled)
                            }
                        }
                    }
                    if self.playedNotPlayed.text == "Not Played"{
                        self.playNow.isEnabled = true
                    }
                }
            }
        }
    }
    
    func retrieveUser() {
        db.collection("users").document(post!.posterID).getDocument { [self] (document, error) in
            
            if let err = error {
                print(err.localizedDescription)
            }else {
                
                if let doc = document {
                let result = Result {
                    try doc.data(as: Users.self)
                   }
                   switch result {
                   case .success(let user):
                    
                       if let user = user {
                        
                        self.user = user
                        if profileButton != nil {
                            profileButton.isEnabled = true
                        }
                    
                       } else {
                           print("Document does not exist")
                       }
                   case .failure(let error):
                
                       print("Error decoding city: \(error)")
                   }
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playNowTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toGame", sender: self)
        
        if defaults.bool(forKey: "Sound") {
            guard let url = Bundle.main.url(forResource: "BeginTwo", withExtension: "wav") else { return }
            player2 = try! AVAudioPlayer(contentsOf: url)
            player2.play()
        }
    }
    
    @IBAction func optionsTapped(_ sender: UIButton) {
        if defaults.bool(forKey: "Haptics") {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }

        let alert = UIAlertController(title: nil, message: "5 reports on a post automatically gets taken down", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Report", style: .destructive, handler: { (_) in
            //
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            //
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func profileTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toUserProfile", sender: self)
    }
    
    
    @IBAction func likeTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if defaults.bool(forKey: "Haptics") {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }

        
        if sender.isSelected {
            if defaults.bool(forKey: "Sound") {
                guard let url = Bundle.main.url(forResource: "DifficultyChanged", withExtension: "wav") else { return }
                player2 = try! AVAudioPlayer(contentsOf: url)
                player2.play()
            }
            db.collection("posts").document(post!.postID).collection("likes").document(userID!).setData(["userRef" : userID!,
                "full name": defaults.string(forKey: "full name")!,
                "username": defaults.string(forKey: "username")!
            ]) { (error) in
                if let _ = error {
                    sender.isSelected = false
                }
            }
        }else {
            
            db.collection("posts").document(post!.postID).collection("likes").document(userID!).delete() { (error) in
                if let _ = error {
                    sender.isSelected = true
                }
            }
        }
    }
    
}

extension GameDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if posts.count < 3 {
        return posts.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedGamesCell", for: indexPath) as! RecentPostCell
        let postIndex = posts[indexPath.row]
        
        cell.postTitle.text = postIndex.title
        if let url = URL(string: postIndex.image){
        cell.postImage.loadImage(from: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _ = self.collectionView.frame
        return CGSize(width: 133, height: 167)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toGameDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            let destinationVC = segue.destination as! NewGameViewController
            destinationVC.post = self.post
            destinationVC.color = self.color
            destinationVC.likes = self.likesToSend
            destinationVC.plays = self.playsToSend
            destinationVC.playedOnceToRecieve = self.playOnceToSend
        }
        if segue.identifier == "toUserProfile" {
            let destinationVC = segue.destination as! UserDetailsViewController
            destinationVC.userDetails = self.post!.posterID
            destinationVC.docID = self.post!.posterID
            destinationVC.retrievedName = user?.fullName
            destinationVC.retrievedUsername = user?.username
            destinationVC.retrievedScore = String(user?.score ?? 0)
            destinationVC.path = user?.profilePic
            }
        
        if segue.identifier == "toGameDetails" {
            let destinationVC = segue.destination as! GameDetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems?[0]
            destinationVC.post = posts[indexPath!.row]
        }
    }
    
    
}
