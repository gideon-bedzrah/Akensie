//
//  LeaderboardTableViewCell.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 19/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var position: Int = 0 {
        didSet {
            if position == 1 {
                positionLabel.text = "1st"
            }else if position == 2 {
                positionLabel.text = "2nd"
            }else if position == 3{
                positionLabel.text = "3rd"
            }else {
                positionLabel.text = "\(position)th"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconView.image = UIImage(named: "IconProfilee")
        iconView.layer.cornerRadius = iconView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
