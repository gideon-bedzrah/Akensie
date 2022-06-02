//
//  GameModePopUp.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 21/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

protocol GameModeDelegate {
    func normalTapped()
}

class GameModePopUp: UIViewController {

    @IBOutlet weak var normalModeButton: UIButton!
    @IBOutlet weak var timedModeButton: UIButton!
    @IBOutlet weak var versusModeButton: UIButton!
    
    @IBOutlet weak var selectedModeLabel: UILabel!
    @IBOutlet weak var replaysLeftLabel: UILabel!
    
    
    var gameModeDelegate: GameModeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonImage(name: "heart.text.square", button: normalModeButton, selected: "heart.text.square.fill")
        buttonImage(name: "hare", button: timedModeButton, selected: "hare.fill")
        buttonImage(name: "person.2", button: versusModeButton, selected: "person.2.fill")
        
       
        
        if defaults.string(forKey: "Mode") != nil {
            
            if defaults.string(forKey: "Mode") == "Normal" {
                normalSelection()
            }else if defaults.string(forKey: "Mode") == "Timed" {
                timedSelection()
            }else {
                versusSelection()
            }
            
        }else {
            normalSelection()
        }
        
    }

    @IBAction func modeTapped(_ sender: UIButton) {
        
        if sender == normalModeButton {
            normalSelection()
        }else if sender == timedModeButton {
            timedSelection()
        }else {
            versusSelection()
        }
        
        self.gameModeDelegate?.normalTapped()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func buttonImage(name: String, button: UIButton, selected: String) {
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .small)

         let largeBoldDoc = UIImage(systemName: name, withConfiguration: largeConfig)
        let largeSelected = UIImage(systemName: selected, withConfiguration: largeConfig)

        button.setImage(largeBoldDoc, for: .normal)
        button.setImage(largeSelected, for: .selected)
        
        
        
    }

    func normalSelection() {
        normalModeButton.isSelected = true
        timedModeButton.isSelected = false
        versusModeButton.isSelected = false
        
        selectedModeLabel.text = "Normal Mode"
        defaults.setValue("Normal", forKey: "Mode")
    }
    
    func timedSelection() {
        normalModeButton.isSelected = false
        timedModeButton.isSelected = true
        versusModeButton.isSelected = false
        
        selectedModeLabel.text = "Timed Mode"
        defaults.setValue("Timed", forKey: "Mode")
    }
    
    func versusSelection() {
        normalModeButton.isSelected = false
        timedModeButton.isSelected = false
        versusModeButton.isSelected = true
        
        selectedModeLabel.text = "Versus Mode"
        defaults.setValue("Versus", forKey: "Mode")
    }
}
