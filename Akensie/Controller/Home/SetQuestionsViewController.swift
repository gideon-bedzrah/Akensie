//
//  SetQuestionsViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 07/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class SetQuestionsViewController: UIViewController, PopupDelegate {
    
    var MYpopupView:SubmittedViewController!
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewTwo: UIScrollView!
    @IBOutlet weak var scrollViewThree: UIScrollView!
    
    @IBOutlet weak var swipeView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // first question
    @IBOutlet weak var questionOne: UITextField!
    @IBOutlet weak var answerOne1: UITextField!
    @IBOutlet weak var answerTwo1: UITextField!
    
    @IBOutlet weak var questionOneTick: UIImageView!
    @IBOutlet weak var answerOneTick1: UIImageView!
    @IBOutlet weak var answerTwoTick1: UIImageView!
    
    // second question
    @IBOutlet weak var questionTwo: UITextField!
    @IBOutlet weak var answerOne2: UITextField!
    @IBOutlet weak var answerTwo2: UITextField!
    
    @IBOutlet weak var questionTwoTick: UIImageView!
    @IBOutlet weak var answerOneTick2: UIImageView!
    @IBOutlet weak var answerTwoTick2: UIImageView!
    
    //third question
    @IBOutlet weak var questionThree: UITextField!
    @IBOutlet weak var answerOne3: UITextField!
    @IBOutlet weak var answerTwo3: UITextField!
    
    @IBOutlet weak var questionThreeTick: UIImageView!
    @IBOutlet weak var answerOneTick3: UIImageView!
    @IBOutlet weak var answerTwoTick3: UIImageView!
    
    //four question
    @IBOutlet weak var questionFour: UITextField!
    @IBOutlet weak var answerOne4: UITextField!
    @IBOutlet weak var answerTwo4: UITextField!
    
    @IBOutlet weak var questionFourTick: UIImageView!
    @IBOutlet weak var answerOneTick4: UIImageView!
    @IBOutlet weak var answerTwoTick4: UIImageView!
    
    //fifth question
    @IBOutlet weak var questionFive: UITextField!
    @IBOutlet weak var answerOne5: UITextField!
    @IBOutlet weak var answerTwo5: UITextField!
    
    @IBOutlet weak var questionFiveTick: UIImageView!
    @IBOutlet weak var answerOneTick5: UIImageView!
    @IBOutlet weak var answerTwoTick5: UIImageView!
    
    //sixth question
    @IBOutlet weak var questionSix: UITextField!
    @IBOutlet weak var answerOne6: UITextField!
    @IBOutlet weak var answerTwo6: UITextField!
    
    @IBOutlet weak var questionSixTick: UIImageView!
    @IBOutlet weak var answerOneTick6: UIImageView!
    @IBOutlet weak var answerTwoTick6: UIImageView!
    
    
    //seven question
    @IBOutlet weak var questionSeven: UITextField!
    @IBOutlet weak var answerOne7: UITextField!
    @IBOutlet weak var answerTwo7: UITextField!
    
    @IBOutlet weak var questionSevenTick: UIImageView!
    @IBOutlet weak var answerOneTick7: UIImageView!
    @IBOutlet weak var answerTwoTick7: UIImageView!
    
    
    //eigth question
    @IBOutlet weak var questionEight: UITextField!
    @IBOutlet weak var answerOne8: UITextField!
    @IBOutlet weak var answerTwo8: UITextField!
    
    @IBOutlet weak var questionEightTick: UIImageView!
    @IBOutlet weak var answerOneTick8: UIImageView!
    @IBOutlet weak var answerTwoTick8: UIImageView!
    
    //nineth question
    @IBOutlet weak var questionNine: UITextField!
    @IBOutlet weak var answerOne9: UITextField!
    @IBOutlet weak var answerTwo9: UITextField!
    
    @IBOutlet weak var questionNineTick: UIImageView!
    @IBOutlet weak var answerOneTick9: UIImageView!
    @IBOutlet weak var answerTwoTick9: UIImageView!
    
    
    @IBOutlet weak var questionOneSegment: UISegmentedControl!
    @IBOutlet weak var questionTwoSegment: UISegmentedControl!
    @IBOutlet weak var questionThreeSegment: UISegmentedControl!
    @IBOutlet weak var questionFourSegment: UISegmentedControl!
    @IBOutlet weak var questionFiveSegment: UISegmentedControl!
    @IBOutlet weak var questionSixSegment: UISegmentedControl!
    @IBOutlet weak var questionSevenSegment: UISegmentedControl!
    @IBOutlet weak var questionEightSegment: UISegmentedControl!
    @IBOutlet weak var questionNineSegment: UISegmentedControl!
    
    
    var selectOptionforOne: String!
    var selectOptionforTwo: String!
    var selectOptionforThree: String!
    var selectOptionforFour: String!
    var selectOptionforFive: String!
    var selectOptionforSix: String!
    var selectOptionforSeven: String!
    var selectOptionforEight: String!
    var selectOptionforNine: String!
    
    let uuid = UUID().uuidString
    var thisPost: DocumentReference!
    
    var PostTitle: String!
    var PostCaption:String!
    var postImage: UIImage!
    var imageUrl: String!
    let storage = Storage.storage()
    var playOnceToRecieve: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.delegate = self
        
        title = PostTitle!
        thisPost = db.collection("posts").document()

        // first question
        questionOne.delegate = self
        answerOne1.delegate = self
        answerTwo1.delegate = self
        questionOneTick.isHidden = true
        answerOneTick1.isHidden = true
        answerTwoTick1.isHidden = true
        
        // second question
        questionTwo.delegate = self
        answerOne2.delegate = self
        answerTwo2.delegate = self
        questionTwoTick.isHidden = true
        answerOneTick2.isHidden = true
        answerTwoTick2.isHidden = true
        
        // third question
        questionThree.delegate = self
        answerOne3.delegate = self
        answerTwo3.delegate = self
        questionThreeTick.isHidden = true
        answerOneTick3.isHidden = true
        answerTwoTick3.isHidden = true
        
        //fourth question
        questionFour.delegate = self
        answerOne4.delegate = self
        answerTwo4.delegate = self
        questionFourTick.isHidden = true
        answerOneTick4.isHidden = true
        answerTwoTick4.isHidden = true
        
        //fiveth question
        questionFive.delegate = self
        answerOne5.delegate = self
        answerTwo5.delegate = self
        questionFiveTick.isHidden = true
        answerOneTick5.isHidden = true
        answerTwoTick5.isHidden = true
        
        //sixth question
        questionSix.delegate = self
        answerOne6.delegate = self
        answerTwo6.delegate = self
        questionSixTick.isHidden = true
        answerOneTick6.isHidden = true
        answerTwoTick6.isHidden = true
        
        //seventh question
        questionSeven.delegate = self
        answerOne7.delegate = self
        answerTwo7.delegate = self
        questionSevenTick.isHidden = true
        answerOneTick7.isHidden = true
        answerTwoTick7.isHidden = true
        
        //eighth question
        questionEight.delegate = self
        answerOne8.delegate = self
        answerTwo8.delegate = self
        questionEightTick.isHidden = true
        answerOneTick8.isHidden = true
        answerTwoTick8.isHidden = true
        
        //nineth question
        questionNine.delegate = self
        answerOne9.delegate = self
        answerTwo9.delegate = self
        questionNineTick.isHidden = true
        answerOneTick9.isHidden = true
        answerTwoTick9.isHidden = true
        
        // Keyboard notification
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
            scrollViewTwo.contentInset = .zero
            scrollViewThree.contentInset = .zero

        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height + 170) - view.safeAreaInsets.bottom, right: 0)
            scrollViewTwo.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height + 170) - view.safeAreaInsets.bottom, right: 0)
            scrollViewThree.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height + 170) - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollViewTwo.scrollIndicatorInsets = scrollView.contentInset
        scrollViewThree.scrollIndicatorInsets = scrollView.contentInset

//        let selectedRange = scrollView.selectedRange
//        scrollView.scrollRangeToVisible(selectedRange)
    }
    
    
    @IBAction func submitTapped(_ sender: UIBarButtonItem){
        
        resignAllKeyboards()
        
        if questionOneTick.isHidden || questionTwoTick.isHidden || questionThreeTick.isHidden || questionFourTick.isHidden || questionFiveTick.isHidden || questionSixTick.isHidden || questionSevenTick.isHidden || questionEightTick.isHidden || questionNineTick.isHidden || answerOneTick1.isHidden || answerOneTick2.isHidden || answerOneTick3.isHidden || answerOneTick4.isHidden || answerOneTick5.isHidden || answerOneTick6.isHidden || answerOneTick7.isHidden || answerOneTick8.isHidden || answerOneTick9.isHidden || answerTwoTick1.isHidden || answerTwoTick2.isHidden || answerTwoTick3.isHidden || answerTwoTick4.isHidden || answerTwoTick5.isHidden || answerTwoTick6.isHidden || answerTwoTick7.isHidden || answerTwoTick8.isHidden || answerTwoTick9.isHidden {
            
            let alert = UIAlertController(title: "Yie!", message: "Please note that all fields are required to submit Post", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            }))
            
            self.present(alert, animated: true, completion: nil)
            //
        } else {
            
            correctOptions()
            openAlert()
            
            if let docID = defaults.string(forKey: "documentID") {
                
                guard let imageData = postImage.jpegData(compressionQuality: 0.5) else {return}
                
                let ImageRef = storage.reference(withPath: "postImage/\(uuid).jpg")
                
                
                _ = ImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    guard metadata != nil else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type.

                    // You can also access to download URL after upload.
                    ImageRef.downloadURL { [self] (url, error) in
                        if error != nil {
                            uploadFailed()
//                            let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
//                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
                        } else {
                            guard let downloadURL = url else {
                                uploadFailed()
//                                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                            
                            let post = NewPosts(title: PostTitle,
                                                caption: PostCaption,
                                                time: Date(),
                                                image: downloadURL.absoluteString,
                                                posterID: docID,
                                                likesCount: 0,
                                                postID: String(),
                                                playsCount: 0,
                                                userfullname: defaults.string(forKey: "full name")!,
                                                userUsername: defaults.string(forKey: "username")!, playOnce: playOnceToRecieve,
                                                questions: [
                                                    // question One
                                                    NewQuestion(question: questionOne.text!,
                                                                answerOne: answerOne1.text!,
                                                                answerTwo: answerTwo1.text!,
                                                                correctAnswer: selectOptionforOne),
                                                    
                                                    // question Two
                                                    NewQuestion(question: questionTwo.text!,
                                                                answerOne: answerOne2.text!,
                                                                answerTwo: answerTwo2.text!,
                                                                correctAnswer: selectOptionforTwo),
                                                    
                                                    // question Three
                                                    NewQuestion(question: questionThree.text!,
                                                                answerOne: answerOne3.text!,
                                                                answerTwo: answerTwo3.text!,
                                                                correctAnswer: selectOptionforThree),
                                                    
                                                    // question Four
                                                    NewQuestion(question: questionFour.text!,
                                                                answerOne: answerOne4.text!,
                                                                answerTwo: answerTwo4.text!,
                                                                correctAnswer: selectOptionforFour),
                                                    
                                                    // question Five
                                                    NewQuestion(question: questionFive.text!,
                                                                answerOne: answerOne5.text!,
                                                                answerTwo: answerTwo5.text!,
                                                                correctAnswer: selectOptionforFive),
                                                    
                                                    // question Six
                                                    NewQuestion(question: questionSix.text!,
                                                                answerOne: answerOne6.text!,
                                                                answerTwo: answerTwo6.text!,
                                                                correctAnswer: selectOptionforSix),
                                                    
                                                    // question Seven
                                                    NewQuestion(question: questionSeven.text!,
                                                                answerOne: answerOne7.text!,
                                                                answerTwo: answerTwo7.text!,
                                                                correctAnswer: selectOptionforSeven),
                                                    
                                                    // question Eight
                                                    NewQuestion(question: questionEight.text!,
                                                                answerOne: answerOne8.text!,
                                                                answerTwo: answerTwo8.text!,
                                                                correctAnswer: selectOptionforEight),
                                                    
                                                    // question Nine
                                                    NewQuestion(question: questionNine.text!,
                                                                answerOne: answerOne9.text!,
                                                                answerTwo: answerTwo9.text!,
                                                                correctAnswer: selectOptionforNine)
                                                    
                                                ])
                            
                            do {
                                self.thisPost = db.collection("posts").document()
                                try thisPost.setData(from: post)
                                thisPost.updateData(["postID" : thisPost.documentID]) { (error) in
                                    if let err = error {
                                        print(err.localizedDescription)
                                        uploadFailed()
                                    }
                                }
                                thisPost.updateData(["userRefs" : db.collection("users").document(docID)]) { (error) in
                                    if let err = error {
                                        print(err.localizedDescription)
                                        uploadFailed()
                                    }else {
                                        uploadComplete()
                                        db.collection("users").document(docID).collection("scores").document("Your Game: \(PostTitle ?? "")").setData(["GameScore" : 200], merge: true)
                                    }
                                }
            
                            } catch let error {
                                print("Error writing city to Firestore: \(error)")
                                uploadFailed()
                            }
                            
                        }
                    }
                }
                
            }
        }
        
    }

    
    @objc func openAlert() {
        MYpopupView = SubmittedViewController(nibName:"SubmittedViewController", bundle: nil)
//        MYpopupView.doneButton.isHidden = true
        self.view.alpha = 1.0
        MYpopupView.closePopup = self
        self.presentpopupViewController(popupViewController: MYpopupView, animationType: .Fade, completion: {() -> Void in
        })
        
    }
    func closeTapped() {
        
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
        
        if MYpopupView.doneButton.currentTitle == "Done" {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
   @objc func uploadComplete() {
    MYpopupView.uploadComplete()
    }
    func uploadFailed() {
        MYpopupView.errorOccurred()
    }
   
    func correctOptions() {
        if questionOneSegment.selectedSegmentIndex == 0 {
            selectOptionforOne = answerOne1.text!
        }else {
            selectOptionforOne = answerTwo1.text!
        }
        
        if questionTwoSegment.selectedSegmentIndex == 0 {
            selectOptionforTwo = answerOne2.text!
        }else {
            selectOptionforTwo = answerTwo2.text!
        }
        
        if questionThreeSegment.selectedSegmentIndex == 0 {
            selectOptionforThree = answerOne3.text!
        }else {
            selectOptionforThree = answerTwo3.text!
        }
        
        if questionFourSegment.selectedSegmentIndex == 0 {
            selectOptionforFour = answerOne4.text!
        }else {
            selectOptionforFour = answerTwo4.text!
        }
        
        if questionFiveSegment.selectedSegmentIndex == 0 {
            selectOptionforFive = answerOne5.text!
        }else {
            selectOptionforFive = answerTwo5.text!
        }
        
        if questionSixSegment.selectedSegmentIndex == 0 {
            selectOptionforSix = answerOne6.text!
        }else {
            selectOptionforSix = answerTwo6.text!
        }
        
        if questionSevenSegment.selectedSegmentIndex == 0 {
            selectOptionforSeven = answerOne7.text!
        }else {
            selectOptionforSeven = answerTwo7.text!
        }
        
        if questionEightSegment.selectedSegmentIndex == 0 {
            selectOptionforEight = answerOne8.text!
        }else {
            selectOptionforEight = answerTwo8.text!
        }
        
        if questionNineSegment.selectedSegmentIndex == 0 {
            selectOptionforNine = answerOne9.text!
        }else {
            selectOptionforNine = answerTwo9.text!
        }
    }
    
    func resignAllKeyboards () {
        //1
        questionOne.resignFirstResponder()
        answerOne1.resignFirstResponder()
        answerTwo1.resignFirstResponder()
        
        //2
        questionTwo.resignFirstResponder()
        answerOne2.resignFirstResponder()
        answerTwo2.resignFirstResponder()
        
        //3
        questionThree.resignFirstResponder()
        answerOne3.resignFirstResponder()
        answerTwo3.resignFirstResponder()
        
        //4
        questionFour.resignFirstResponder()
        answerOne4.resignFirstResponder()
        answerTwo4.resignFirstResponder()
        
        //5
        questionFive.resignFirstResponder()
        answerOne5.resignFirstResponder()
        answerTwo5.resignFirstResponder()
        
        //6
        questionSix.resignFirstResponder()
        answerOne6.resignFirstResponder()
        answerTwo6.resignFirstResponder()
        
        //7
        questionSeven.resignFirstResponder()
        answerOne7.resignFirstResponder()
        answerTwo7.resignFirstResponder()
        
        //8
        questionEight.resignFirstResponder()
        answerOne8.resignFirstResponder()
        answerTwo8.resignFirstResponder()
        
        //9
        questionNine.resignFirstResponder()
        answerOne9.resignFirstResponder()
        answerTwo9.resignFirstResponder()
        
    }
    
}

extension SetQuestionsViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        // first question
        case questionOne:
            if questionOne.text == "" || questionOne.text == " "{
                questionOneTick.isHidden = true
            }else {
                questionOneTick.isHidden = false
            }
            answerOne1.becomeFirstResponder()
        case answerOne1:
            if answerOne1.text == "" || answerOne1.text == " "{
                answerOneTick1.isHidden = true
            }else {
                answerOneTick1.isHidden = false
            }
            answerTwo1.becomeFirstResponder()
        case answerTwo1:
            if answerTwo1.text == "" || answerTwo1.text == " "{
                answerTwoTick1.isHidden = true
            }else {
                answerTwoTick1.isHidden = false
            }
            answerTwo1.resignFirstResponder()
            
        // second question
        case questionTwo:
            if questionTwo.text == "" || questionTwo.text == " "{
                questionTwoTick.isHidden = true
            }else {
                questionTwoTick.isHidden = false
            }
            answerOne2.becomeFirstResponder()
        case answerOne2:
            
            if answerOne2.text == "" || answerOne2.text == " "{
                answerOneTick2.isHidden = true
            }else {
                answerOneTick2.isHidden = false
            }
            
            answerTwo2.becomeFirstResponder()
        case answerTwo2:
            
            if answerTwo2.text == "" || answerTwo2.text == " "{
                answerTwoTick2.isHidden = true
            }else {
                answerTwoTick2.isHidden = false
            }
            
            answerTwo2.resignFirstResponder()
            
        // third question
        case questionThree:
            if questionThree.text == "" || questionThree.text == " "{
                questionThreeTick.isHidden = true
            }else {
                questionThreeTick.isHidden = false
            }
            answerOne3.becomeFirstResponder()
        case answerOne3:
            
            if answerOne3.text == "" || answerOne3.text == " "{
                answerOneTick3.isHidden = true
            }else {
                answerOneTick3.isHidden = false
            }
            
            answerTwo3.becomeFirstResponder()
        case answerTwo3:
            
            if answerTwo2.text == "" || answerTwo2.text == " "{
                answerTwoTick3.isHidden = true
            }else {
                answerTwoTick3.isHidden = false
            }
            answerTwo3.resignFirstResponder()
            
        // fourth question
        case questionFour:
            if questionFour.text == "" || questionFour.text == " "{
                questionFourTick.isHidden = true
            }else {
                questionFourTick.isHidden = false
            }
            answerOne4.becomeFirstResponder()
        case answerOne4:
            
            if answerOne4.text == "" || answerOne4.text == " "{
                answerOneTick4.isHidden = true
            }else {
                answerOneTick4.isHidden = false
            }
            
            answerTwo4.becomeFirstResponder()
        case answerTwo4:
            
            if answerTwo4.text == "" || answerTwo4.text == " "{
                answerTwoTick4.isHidden = true
            }else {
                answerTwoTick4.isHidden = false
            }
            answerTwo4.resignFirstResponder()
            
        //fiveth question
        case questionFive:
            if questionFive.text == "" || questionFive.text == " "{
                questionFiveTick.isHidden = true
            }else {
                questionFiveTick.isHidden = false
            }
            answerOne5.becomeFirstResponder()
        case answerOne5:
            
            if answerOne5.text == "" || answerOne5.text == " "{
                answerOneTick5.isHidden = true
            }else {
                answerOneTick5.isHidden = false
            }
            
            answerTwo5.becomeFirstResponder()
        case answerTwo5:
            
            if answerTwo5.text == "" || answerTwo5.text == " "{
                answerTwoTick5.isHidden = true
            }else {
                answerTwoTick5.isHidden = false
            }
            answerTwo5.resignFirstResponder()
            
        //sixeth question
        case questionSix:
            if questionSix.text == "" || questionSix.text == " "{
                questionSixTick.isHidden = true
            }else {
                questionSixTick.isHidden = false
            }
            answerOne6.becomeFirstResponder()
        case answerOne6:
            
            if answerOne6.text == "" || answerOne6.text == " "{
                answerOneTick6.isHidden = true
            }else {
                answerOneTick6.isHidden = false
            }
            
            answerTwo6.becomeFirstResponder()
        case answerTwo6:
            
            if answerTwo6.text == "" || answerTwo6.text == " "{
                answerTwoTick6.isHidden = true
            }else {
                answerTwoTick6.isHidden = false
            }
            answerTwo6.resignFirstResponder()
            
        //seven question
        case questionSeven:
            if questionSeven.text == "" || questionSeven.text == " "{
                questionSevenTick.isHidden = true
            }else {
                questionSevenTick.isHidden = false
            }
            answerOne7.becomeFirstResponder()
        case answerOne7:
            
            if answerOne7.text == "" || answerOne7.text == " "{
                answerOneTick7.isHidden = true
            }else {
                answerOneTick7.isHidden = false
            }
            
            answerTwo7.becomeFirstResponder()
        case answerTwo7:
            
            if answerTwo7.text == "" || answerTwo7.text == " "{
                answerTwoTick7.isHidden = true
            }else {
                answerTwoTick7.isHidden = false
            }
            answerTwo7.resignFirstResponder()
            
        //eigth question
        case questionEight:
            if questionEight.text == "" || questionEight.text == " "{
                questionEightTick.isHidden = true
            }else {
                questionEightTick.isHidden = false
            }
            answerOne8.becomeFirstResponder()
        case answerOne8:
            
            if answerOne8.text == "" || answerOne8.text == " "{
                answerOneTick8.isHidden = true
            }else {
                answerOneTick8.isHidden = false
            }
            
            answerTwo8.becomeFirstResponder()
        case answerTwo8:
            
            if answerTwo8.text == "" || answerTwo8.text == " "{
                answerTwoTick8.isHidden = true
            }else {
                answerTwoTick8.isHidden = false
            }
            answerTwo8.resignFirstResponder()
            
        // nineth question
        case questionNine:
            if questionNine.text == "" || questionNine.text == " "{
                questionNineTick.isHidden = true
            }else {
                questionNineTick.isHidden = false
            }
            answerOne9.becomeFirstResponder()
        case answerOne9:
            
            if answerOne9.text == "" || answerOne9.text == " "{
                answerOneTick9.isHidden = true
            }else {
                answerOneTick9.isHidden = false
            }
            
            answerTwo9.becomeFirstResponder()
        case answerTwo9:
            
            if answerTwo9.text == "" || answerTwo9.text == " "{
                answerTwoTick9.isHidden = true
            }else {
                answerTwoTick9.isHidden = false
            }
            answerTwo9.resignFirstResponder()
            
        default:
            textField.resignFirstResponder()
            //
        }
        
        return false
    }
    
}

extension SetQuestionsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
        
        if pageControl.currentPage == 0 {
//            descriptionText.text = "Learn more about which events and people shaped Ghana."
//            page = 1
//            signButton.setTitle("Continue", for: .normal)
        } else if pageControl.currentPage == 1 {
//            descriptionText.text = "Explore popular categories handpicked by the very best."
//            page = 2
//            signButton.setTitle("Continue", for: .normal)
        }else if pageControl.currentPage == 2 {
//            descriptionText.text = "Compete to be on top with live leaderboard updates and challenges."
//            page = 3
//            continueButton.isHidden = false
//            signButton.setTitle("Sign up to play", for: .normal)
        }
    }
}
