//
//  PopupViewController.swift
//  Custom Popup
//
//  Created by Parth Changela on 11/05/19.
//  Copyright © 2019 parth. All rights reserved.
//

import UIKit

protocol PopupDelegate {
    func closeTapped()
}


class PopupViewController: UIViewController {

    var closePopup:PopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnCloseTapped(_ sender: Any) {
        self.closePopup?.closeTapped()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
