//
//  UserViewCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 27/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class UserViewCell: UITableViewCell {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var totalPositionLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    let db = Firestore.firestore()
    
    var userID: String?
    
    var docID: String? {
        didSet{
//            checkFollowing()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
//        followButton.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
//        followButton.setTitle(" Add Friend", for: .normal)
//        followButton.setImage(UIImage(systemName: "person.crop.circle.fill.badge.checkmark"), for: .selected)
//        followButton.setTitle(" Following", for: .selected)
//        
        
    }
    
    
    func checkFollowing() {
        followButton = nil
        if docID != userID {
        db.collection("users").document(docID!).collection("followers").addSnapshotListener { (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot {
                    for s in snap.documents {
                        if s.documentID == self.userID {
                            self.followButton.isSelected = true
                        }
                    }
                }
            }
        }
        } else {
            followButton.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addFriendTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        print("my ID = \(userID!)")
        print("my follower's ID = \(docID!)")
//        sender.tintColor = #colorLiteral(red: 0.9725490196, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
        
    }

}
