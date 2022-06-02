//
//  EditProfileCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 16/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class EditProfileCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
