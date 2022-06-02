//
//  HomeTableViewCell.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 09/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var mixedView: UIView!
    @IBOutlet weak var tileImage: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var acceptLabel: UILabel!
    @IBOutlet weak var accentColorView: UIView!
    
    
    

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
       mixedView.layer.cornerRadius = 0
        mixedView.layer.backgroundColor = UIColor.white.cgColor
        mixedView.layer.shadowColor = UIColor.black.cgColor
        mixedView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mixedView.layer.shadowRadius = 2
        mixedView.layer.shadowOpacity = 0.2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    
}
