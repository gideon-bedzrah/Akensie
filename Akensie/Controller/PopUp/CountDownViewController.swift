//
//  CountDownViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 22/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var readyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        typingAnimation()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(begin), userInfo: nil, repeats: false)
        
    }

    @objc func typingAnimation() {
    var chatIndex = 0.0
    let loop = "21"
    for num in loop {
        chatIndex += 1
        Timer.scheduledTimer(withTimeInterval: chatIndex, repeats: false) { (time) in
            self.countDownLabel.text = String(num)
        }
        
    }
    }
    
   @objc func begin() {
    countDownLabel.text = "GO!"
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
