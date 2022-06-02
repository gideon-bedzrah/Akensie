//
//  ResetPasswordViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 07/10/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendEmailTapped(_ sender: UIButton) {
  
           
                
                Auth.auth().sendPasswordReset(withEmail: emailField.text!) { error in
                    
                    if let err = error {
                        print(err.localizedDescription)
                        //present an alert controller
                        
                        let alert = UIAlertController(title: "Yikes", message: err.localizedDescription, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (cancel) in
                            print("Cancel")
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                       
                        let alert = UIAlertController(title: "Congratulations", message: "Email has been successfully sent. New password should be at least 6 characters long with a number", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (done) in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                  // ...
                }
            }

        
    
    
}
