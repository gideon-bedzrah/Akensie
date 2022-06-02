//
//  GameCompleteController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 01/02/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit

protocol completeGameProtocol {
    func returnT()
    func extraT()
    func playA()
}

class GameCompleteController: UIViewController {

    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var playsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playAgainbutton: UIButton!
    
    var delegate: completeGameProtocol?
    
    var gameTitle: String?
    var username: String?
    var plays: Int?
    var likes: Int?
    var score: Int?
    var playOnce: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let g = gameTitle, let u = username, let p = plays, let l = likes, let s = score, let po = playOnce {
            gameTitleLabel.text = g
            usernameLabel.text = u
            playsLabel.text = "\(p) plays"
            likesLabel.text = "\(l) likes"
            scoreLabel.text = "\(s) xp"
            
            if po {playAgainbutton.isEnabled = false}
        }
    }

    @IBAction func returnTapped(_ sender: UIButton) {
        delegate?.returnT()
    }
    
    @IBAction func extraTapped(_ sender: UIButton) {
        delegate?.extraT()
    }
    
    @IBAction func playAgainTapped(_ sender: UIButton) {
        delegate?.playA()
    }
    
}
