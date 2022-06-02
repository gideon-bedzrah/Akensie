//
//  ScoresTableViewCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 24/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {

    
    @IBOutlet weak var subjectName: UILabel!
    
    @IBOutlet weak var easyScore: UILabel!
    @IBOutlet weak var easyTotal: UILabel!
    
    
    @IBOutlet weak var mediumScore: UILabel!
    @IBOutlet weak var mediumTotal: UILabel!
    
    @IBOutlet weak var hardScore: UILabel!
    @IBOutlet weak var hardTotal: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
