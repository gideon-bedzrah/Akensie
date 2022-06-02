//
//  SignUpViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 20/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    let generator = UINotificationFeedbackGenerator()
    
    let db = Firestore.firestore()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        Utilities.textFieldStyle(fullNameField)
        //         Utilities.textFieldStyle(usernameField)
        //         Utilities.textFieldStyle(emailField)
        //         Utilities.textFieldStyle(passwordField)
        
//        errorLabel.alpha = 0
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    @IBAction func backButtonTappped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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

    
    @IBAction func findOutMoreTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func SignUpTapped(_ sender: UIButton) {
        
        if fullNameField.text != "" && usernameField.text != "" && emailField.text != "" && passwordField.text != "" {
            
            if isEmailValid(emailField.text!) {
                if isPasswordValid(passwordField.text!){
                    
                    sender.loadingIndicator(true)
                    
                    Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { [self] (result, error) in
                        if let err = error {
                            signupButton.buttonShake()
                            generator.notificationOccurred(.error)
                            print(err.localizedDescription)
                            self.errorLabel.text = err.localizedDescription
                            self.errorLabel.alpha = 1
                            sender.loadingIndicator(false)
                        }else{
                            
                            let coll = self.db.collection("users").addDocument(data: ["full name" : self.fullNameField.text!,
                                                                                      "username": self.usernameField.text!,
                                                                                      "profilePic": "IconProfile@3x.png",
                                                                                      "score": 0,
                                                                                      "uid": result!.user.uid]){error in
                                if let err = error{
                                    print("error creating user profile: \(err.localizedDescription)")
                                    self.errorLabel.text = "Error creating user"
                                    self.errorLabel.alpha = 1
                                    sender.loadingIndicator(false)
                                }else{
                                    print("data saved successfully")
                                    self.userDefaults.set(true, forKey: "isLoggedIn")
                                    
                                    //                                   result?.additionalUserInfo?.isNewUser ?? true
                                    
                                    
                                    let hVC = self.storyboard?.instantiateViewController(identifier: "WelcomeHome")
                                    self.view.window?.rootViewController = hVC
                                    self.view.window?.makeKeyAndVisible()
                                    
                                    
                                    //add activity indicator
                                }
                            }
                            
                            defaults.set(true, forKey: "Haptics")
                            defaults.set(true, forKey: "Sound")
                            defaults.set(true, forKey: "Music")
                            defaults.set(true, forKey: "Position")
                            defaults.set(false, forKey: "Akan")
                            
                            GameScores.newScore(dociD: coll.documentID, category: Constants.categories.history)
                            GameScores.newScore(dociD: coll.documentID, category: Constants.categories.art)
                            GameScores.newScore(dociD: coll.documentID, category: Constants.categories.general)
                            GameScores.newScore(dociD: coll.documentID, category: Constants.categories.business)
                            GameScores.newScore(dociD: coll.documentID, category: Constants.categories.popCulture)
                            GameScores.newScore(dociD: coll.documentID, category: Constants.categories.technology)
                            GameScores.newBonus(dociD: coll.documentID)
                            
                        }
                        
                    }
                    
                    
                    
                }else {
                    print("password should be 6 characters long with a number")
                    errorLabel.text = "Password should be 6 characters long with a number"
                    signupButton.buttonShake()
                    generator.notificationOccurred(.error)
                }
            }else {
                print("email is badly formatted")
                errorLabel.text = "email is badly formatted"
                signupButton.buttonShake()
                generator.notificationOccurred(.error)
            }
            
        }else {
            errorLabel.text = "Please fill all required spaces"
            signupButton.buttonShake()
            generator.notificationOccurred(.error)
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
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case fullNameField:
            self.usernameField.becomeFirstResponder()
            
        case usernameField:
            self.emailField.becomeFirstResponder()
            
        case emailField:
            self.passwordField.becomeFirstResponder()
            
        case passwordField:
            SignUpTapped(signupButton)
            self.passwordField.resignFirstResponder()
        default:
            resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        errorLabel.alpha = 0
    }
    
}

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            indicator.alpha = 1
            indicator.color = .black
            self.setTitle("", for: .normal)
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            self.setTitle("Sign up", for: .normal)
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
