//
//  ToggleSettingsCell.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 16/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class ToggleSettingsCell: UITableViewCell {

    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var settingsSubLabel: UILabel!
    @IBOutlet weak var stateSwitch: UISwitch!
    
    var state: Bool!
    var defaultname: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if state {
            stateSwitch.setOn(true, animated: true)
        }else {
            stateSwitch.setOn(false, animated: true)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func settingsSwitch(_ sender: UISwitch) {
        

        if sender.isOn {
            defaults.set(true, forKey: defaultname)
        }else {
            defaults.set(false, forKey: defaultname)
        }
    }
    
}
