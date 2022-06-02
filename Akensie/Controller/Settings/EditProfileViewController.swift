//
//  EditProfileViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 19/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class EditProfileViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let db = Firestore.firestore()
    
    var fullNameChanged: Bool = false
    var usernameChanged: Bool = false
    var emailChanged: Bool = false
    var passwordChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       infoEditDisable()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        fullNameField.text = defaults.string(forKey: "full name")
        usernameField.text = defaults.string(forKey: "username")
        
        if let user = Auth.auth().currentUser {
            emailField.text = user.email
        }
        
        fullNameField.delegate = self
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
        
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

        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height + 170) - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    
  @objc private func keyboardAppear() {
    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
    }
    
    @objc private func keyboardDisappear() {
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
      }
    
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fullNameField {
            fullNameChanged = true
        }
        
        if textField == usernameField {
            usernameChanged = true
        }
        
        if textField == emailField {
            emailChanged = true
        }
        
        if textField == passwordField {
            passwordChanged = true
        }
    }
    
//    func textFieldDidChange(_ textField: UITextField) {
//        if textField == fullNameField {
//            fullNameChanged = true
//
//            print("hello")
//            print(fullNameField.text)
//        }
//
//        if textField == usernameField {
//            usernameChanged = true
//        }
//
//        if textField == emailField {
//            emailChanged = true
//        }
//
//        if textField == passwordField {
//            passwordChanged = true
//        }
//    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        infoEditEnable()
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if isEditing {
            infoEditEnable()
            
        }else {
            
            if fullNameChanged || usernameChanged {
                
                if let docID = defaults.string(forKey: "documentID") {
                    db.collection("users").document(docID).updateData(["full name": fullNameField.text!,
                                                                       "username": usernameField.text!]) { [self] (error) in
                        
                        if let err = error {
                            print("error updating user info: \(err)")
                            
                            let alert = UIAlertController(title: "Updating name error", message: err.localizedDescription, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (tryAgain) in
                                self.infoEditEnable()
                                self.isEditing = true
                            }))
                            
                        }else {
                            defaults.set(fullNameField.text!, forKey: "full name")
                            defaults.set(usernameField.text!, forKey: "username")

                            let alert = UIAlertController(title: "Success!", message: "Your name has successfully been updated", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
            }
            
            
            if emailChanged {
                
                if isEmailValid(emailField.text!){
                    
                    Auth.auth().currentUser?.updateEmail(to: emailField.text!) { (error) in
                        
                        if let err = error {
                            print("\(err.localizedDescription)")
                            
                            let alert = UIAlertController(title: "Updating email error", message: err.localizedDescription, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (tryAgain) in
                                self.infoEditEnable()
                                self.isEditing = true
                                self.emailField.becomeFirstResponder()
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }else {
//                            self.infoEditDisable()
                            self.navigationController?.navigationItem.prompt = "Email successfully updated"
                            
                            let alert = UIAlertController(title: "Success!", message: "Your email has been changed successfully.", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    
                }else {
                    let alert = UIAlertController(title: "Updating email error", message: "Your email address is badly formated", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (tryAgain) in
                        self.infoEditEnable()
                        self.emailField.becomeFirstResponder()
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            }
            
            if passwordChanged {
                if isPasswordValid(passwordField.text!){
                    Auth.auth().currentUser?.updatePassword(to: passwordField.text!) { (error) in
                        
                        if let err = error {
                            print("\(err.localizedDescription)")
                            
                            let alert = UIAlertController(title: "Updating password error", message: err.localizedDescription, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (tryAgain) in
                                self.infoEditEnable()
                                self.isEditing = true
                                self.passwordField.becomeFirstResponder()
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }else {
                            self.navigationController?.navigationItem.prompt = "Password successfully updated"
                            
                            let alert = UIAlertController(title: "Success!", message: "Your password has been changed successfully.", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                    }
                }else{
                    let alert = UIAlertController(title: "Updating password error", message: "Your password should be at least 6 characters long and should contain a number", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {
                       _ in
                        self.infoEditEnable()
                        self.isEditing = true
                        self.passwordField.becomeFirstResponder()
                        
                    } ))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            

            infoEditDisable()
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
    
   private func infoEditDisable() {
        
        fullNameField.isUserInteractionEnabled = false
        usernameField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        passwordField.isUserInteractionEnabled = false
        
        fullNameField.borderStyle = .roundedRect
        usernameField.borderStyle = .roundedRect
        emailField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
    
    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
        
    }

    
  private func infoEditEnable() {
        
        fullNameField.isUserInteractionEnabled = true
        usernameField.isUserInteractionEnabled = true
        emailField.isUserInteractionEnabled = true
        passwordField.isUserInteractionEnabled = true
        
        fullNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        fullNameField.borderStyle = .roundedRect
        usernameField.borderStyle = .roundedRect
        emailField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        
        fullNameChanged = false
        usernameChanged = false
        emailChanged = false
        passwordChanged = false
        
    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
    }
}
