//
//  PostedQuestionsCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 10/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit

class PostedQuestionsCell: UITableViewCell, setBackbackground {
    
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    
    @IBOutlet weak var numberOfQuestions: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var viewColor: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selfDelegate: Bool = false {
        didSet {
            UIImageView.changeDelegate = self
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        UIImageView.changeDelegate = self
    }

    func changeColor() {
        DispatchQueue.main.async { [self] in
//            self.viewColor.backgroundColor = UIColor(averageColorFrom: postImage.image, withAlpha: 0.8)
            self.activityIndicator.isHidden = true
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
