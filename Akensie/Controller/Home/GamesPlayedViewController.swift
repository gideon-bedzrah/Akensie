//
//  GamesPlayedViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 11/03/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class GamesPlayedViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let db = Firestore.firestore()
    var posts = [NewPosts]()
    var docID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        retreiveGames()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
   func retreiveGames() {
        guard let d = docID else {return}
        db.collection("posts").whereField("posterID", isEqualTo: d).getDocuments { [self] (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot?.documents{
                    if snap.isEmpty {
                        
                    }
                    for doc in snap {
                        
                        let result = Result {
                            try doc.data(as: NewPosts.self)
                           }
                           switch result {
                           case .success(let posts):
                            
                               if let posts = posts {
                            
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
                    posts.sort(by: {$0.time > $1.time})
                    
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

}

extension GamesPlayedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playedCell", for: indexPath) as! PlayedGamesCell
        let postIndex = posts[indexPath.row]
        
        cell.postLabel.text = postIndex.title
        cell.scoreEarned.text = ""
        if let url = URL(string: postIndex.image){
            cell.postImage.loadImage(from: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width / 2 - 30, height: (bounds.width / 2 - 50) + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
}
