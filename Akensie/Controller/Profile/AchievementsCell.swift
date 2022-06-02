//
//  AchievementsCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 16/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class AchievementsCell: UICollectionViewCell {
    
    @IBOutlet weak var achImage: UIImageView!
    
    @IBOutlet weak var achLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.layer.cornerRadius = 10
        
        
//        achImage.layer.cornerRadius = achImage.frame.height / 2
    }
    
}
