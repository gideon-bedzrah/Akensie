//
//  SubmittedViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 17/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit

class SubmittedViewController: UIViewController {
    
    var closePopup:PopupDelegate?
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var congratsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkmark.isHidden = true
        doneButton.isEnabled = false
        congratsLabel.isHidden = true
        // Do any additional setup after loading the view.
    }


    @IBAction func doneTapped(_ sender: Any) {
        self.closePopup?.closeTapped()
    }
    
    func uploadComplete() {
        doneButton.isEnabled = true
        activityIndicator.isHidden = true
        checkmark.isHidden = false
        statusLabel.text = "Your game has been posted successfully"
        congratsLabel.isHidden = false
    }
    
    func errorOccurred() {
        statusLabel.text = "Oops! An error occurred."
        doneButton.isEnabled = true
        doneButton.setTitle("Cancel", for: .normal)
    }
}

