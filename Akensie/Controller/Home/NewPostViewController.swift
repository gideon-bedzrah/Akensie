//
//  NewPostViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 05/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var topicField: UITextField!
    @IBOutlet weak var captionField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstTick: UIImageView!
    @IBOutlet weak var secondTick: UIImageView!
    @IBOutlet weak var thirdTick: UIImageView!
        
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var playOnceSegment: UISegmentedControl!
    
    var imageToPass: UIImage?
    var playOnceToPass: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicField.delegate = self
        captionField.delegate = self
        
        firstTick.isHidden = true
        secondTick.isHidden = true
        thirdTick.isHidden = true
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    

    @IBAction func close(_ sender: UIButton){
        
        if !firstTick.isHidden || !secondTick.isHidden || !thirdTick.isHidden {
            let alert = UIAlertController(title: "Yie!", message: "Please note that all unsaved progress would be lost", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
        
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func uploadImage(_ sender: UIButton){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alert = UIAlertController(title: "Upload Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (action) in
        
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            imageToPass = editedImage
            postImage.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imageToPass = originalImage
            postImage.image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        if imageToPass != nil {
            thirdTick.isHidden = false
        }
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

//        let selectedRange = scrollView.selectedRange
//        scrollView.scrollRangeToVisible(selectedRange)
    }
    @IBAction func nextTapped(_ sender: UIBarButtonItem) {
        
        if firstTick.isHidden || secondTick.isHidden || thirdTick.isHidden {
            let alert = UIAlertController(title: "Cannot Continue", message: "All fields are required in order to continue", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            if playOnceSegment.selectedSegmentIndex == 0 {
                playOnceToPass = false
            }else {
                playOnceToPass = true
            }
            
        performSegue(withIdentifier: "toQuestionDetail", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestionDetail" {
            let destinationVC = segue.destination as! SetQuestionsViewController
            destinationVC.PostTitle = topicField.text
            destinationVC.PostCaption = captionField.text
            destinationVC.postImage = imageToPass
            destinationVC.playOnceToRecieve = playOnceToPass
        }
    }
    
}

extension NewPostViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case topicField:
            if topicField.text == "" || topicField.text == " "{
                firstTick.isHidden = true
            }else {
                firstTick.isHidden = false
            }
            self.topicField.resignFirstResponder()
        case captionField:
            if captionField.text == "" || captionField.text == " "{
                secondTick.isHidden = true
            }else {
                secondTick.isHidden = false
            }
            self.captionField.resignFirstResponder()
        default:
            resignFirstResponder()
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case topicField:
            firstTick.isHidden = true
        case captionField:
            secondTick.isHidden = true
        default:
            firstTick.isHidden = true
            secondTick.isHidden = true
        }
    }
}
