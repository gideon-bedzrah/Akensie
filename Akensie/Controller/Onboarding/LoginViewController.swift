//
//  LoginViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 20/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
     @IBOutlet weak var loginButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    let generator = UINotificationFeedbackGenerator()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        Utilities.textFieldStyle(emailField)
//        Utilities.textFieldStyle(passwordField)
//        errorLabel.alpha = 0
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
            scrollView.scrollsToTop = true
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height + 170) - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset

    }

    
    
    
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        
//        toForgotPassword
    }
    
    @IBAction func backButtonTappped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if emailField.text != "" && passwordField.text != "" {
            
            if isEmailValid(emailField.text!) {
                if isPasswordValid(passwordField.text!){
                    
                    sender.loadingIndicator(true)
                    
                    Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { [self] result, error in
                        
                        if let err = error {
//                            print(err.localizedDescription)
                            
                            loginButton.buttonShake()
                            generator.notificationOccurred(.error)
                            
                            sender.loadingIndicator(false)
                            if err.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                                self.errorLabel.text = "User doesn't exist. Sign up on the sign up page"
                            }else if err.localizedDescription == "The password is invalid or the user does not have a password." {
                                self.errorLabel.text = "Your password is incorrect"
                            } else if err.localizedDescription == "Network error (such as timeout, interrupted connection or unreachable host) has occurred."{
                                self.errorLabel.text = "Network error. Please make sure you are connected to the internet"
                            }else {
                                self.errorLabel.text = err.localizedDescription
                            }
                            
                            
                            self.errorLabel.alpha = 1
                        } else {
                            self.userDefaults.set(true, forKey: "isLoggedIn")
                            let hVC = self.storyboard?.instantiateViewController(identifier: "WelcomeHome")
                            self.view.window?.rootViewController = hVC
                            self.view.window?.makeKeyAndVisible()
                            
                            defaults.set(true, forKey: "Haptics")
                            defaults.set(true, forKey: "Sound")
                            defaults.set(true, forKey: "Music")
                            defaults.set(true, forKey: "Position")
                            defaults.set(false, forKey: "Akan")
                            
//                            self.userDefaults.set(document.documentID, forKey: "documentID")
//                            self.userDefaults.set(retrievedname as? String, forKey: "full name")
//                            self.userDefaults.set(retrieveTag as? String, forKey: "username")
//                            self.userDefaults.set(retrieveScore as? Int, forKey: "score")
                        }
                        
                    }
                    
                    
                    
                }else {
                    print("password should be 6 characters long with a number")
                    errorLabel.text = "Password should be 6 characters long with a number"
                    loginButton.buttonShake()
                    generator.notificationOccurred(.error)
                }
                
                
            }else {
                print("email is badly formatted")
                errorLabel.text = "email is badly formatted"
                loginButton.buttonShake()
                generator.notificationOccurred(.error)
            }
            
        }else {
            errorLabel.text = "Please fill all required spaces"
            loginButton.buttonShake()
            generator.notificationOccurred(.error)
            
        }
    
        
        
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        errorLabel.alpha = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            loginTapped(loginButton)
            self.passwordField.resignFirstResponder()
        default:
            resignFirstResponder()
        }
        return false
    }
    
}



func isEmailValid(_ email: String) -> Bool{
         let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
         return emailTest.evaluate(with: email)
     }
   
   func isPasswordValid(_ password: String) -> Bool {
       let predicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9]).{6,}")
       return predicate.evaluate(with: password)
   }



struct Utilities {
    
    static func textFieldStyle(_ textField: UITextField) {
        
        //create bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height/1.5, width: textField.frame.width, height: 2.0)
        bottomLine.backgroundColor = UIColor.label.cgColor
        
        //add bottom line to textfield
        textField.layer.addSublayer(bottomLine)
        textField.borderStyle = .none
    }
}
