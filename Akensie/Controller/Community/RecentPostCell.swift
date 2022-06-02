//
//  RecentPostCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 26/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore

protocol deletePostProtocol {
    func deleteSuccessfull(_ indexPath: IndexPath)
    func deletefailed()
}

class RecentPostCell: UICollectionViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    let db = Firestore.firestore()
    
    var delegate: deletePostProtocol?
    
    var show: Bool? {
        didSet {
            if show ?? false {deleteButton.isHidden = false} else {deleteButton.isHidden = true}
        }
    }
    
    var postID: String?
    var postName: String?
    var indexPath: IndexPath?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton!) {
    
        let alert = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete \(postName ?? "")?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (_) in
            print("deleting this post")
//            delegate?.deleteSuccessfull()
            db.collection("posts").document(postID ?? "").delete { (error) in
                if let _ = error {
                    delegate?.deletefailed()

                }else{
                    delegate?.deleteSuccessfull(indexPath!)
                    
                    
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
