//
//  NewGameViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 11/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation
import GoogleMobileAds

class NewGameViewController: UIViewController, completeGameProtocol, GADRewardedAdDelegate {
  
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    
    @IBOutlet weak var questionProgress: UIProgressView!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let db = Firestore.firestore()
    var numberOfQuestions = 0
    var post: NewPosts? {
        didSet {
            numberOfQuestions = (post?.questions.count)!
        }
    }
    var color: UIColor?
    
    var questionTrack = 0
    var score = 0
    let userID = defaults.string(forKey: "documentID")
    var player2: AVAudioPlayer!
    var plays: Int?
    var likes: Int?
    let generator = UINotificationFeedbackGenerator()
    var rewardedAd: GADRewardedAd?
    var playedOnceToRecieve: Bool?
    var imageToRecieve: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = post {
            topicLabel.text = p.title
            usernameLabel.text = "by \(p.userUsername)"
            if let url = URL(string: p.image){
                backgroundImage.loadImage(from: url)
            }
        }
        
        if let c = self.color {
            questionView.backgroundColor = c
            answerView.backgroundColor = c
        }
        
        buttonStyle(answerOneButton)
        buttonStyle(answerTwoButton)
        questionProgress.progress = 0
        
        
        questionLabel.text = post?.questions[questionTrack].question
        answerOneButton.setTitle(post?.questions[questionTrack].answerOne, for: .normal)
        answerTwoButton.setTitle(post?.questions[questionTrack].answerTwo, for: .normal)
        
        scoreLabel.text = "Score: \(score)"
        
        self.likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .selected)
        self.likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        
        likesCount()
        
        let testAd = "ca-app-pub-3940256099942544/1712485313"
        let adUnit = "ca-app-pub-4276347716468242/7226990428"
        rewardedAd = GADRewardedAd(adUnitID: adUnit)
        
        rewardedAd?.load(GADRequest()) { error in
           if let err = error {
             // Handle ad failed to load case.
             print("enable to present video ad: \(err)")
           } else {
             // Ad successfully loaded.
           }
         }
        exitButton.isOpaque = true
    }
    
    func likesCount() {
        db.collection("posts").document(post!.postID).collection("likes").addSnapshotListener { (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot {
                    for s in snap.documents {
                        if s.documentID == self.userID {
                            self.likeButton.isSelected = true
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        openAlert()
        Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(closeTapped), userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton){
        if exitButton.isOpaque == false {
            exitButton.alpha = 1
            exitButton.isOpaque = true
        }else{
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .selected)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        exitButton.isOpaque = false
        exitButton.alpha = 0.2
        
        let userAnswer = sender.currentTitle!
        
        if userAnswer == post?.questions[questionTrack].correctAnswer {
            sender.buttonPulse()
            sender.backgroundColor = UIColor(hexString: "A3D68E")
                score += 10
            if defaults.bool(forKey: "Haptics"){
                generator.notificationOccurred(.success)
            }
            if defaults.bool(forKey: "Sound") {
                guard let url = Bundle.main.url(forResource: "Correct", withExtension: "wav") else { return }
                player2 = try! AVAudioPlayer(contentsOf: url)
                player2.play()
            }
        }else {
            sender.buttonShake()
            sender.backgroundColor = UIColor(hexString: "FC7D7D")
            
            if defaults.bool(forKey: "Haptics"){
                generator.notificationOccurred(.error)
            }
            
            if defaults.bool(forKey: "Sound") {
                guard let url = Bundle.main.url(forResource: "Wrong", withExtension: "mp3") else { return }
                player2 = try! AVAudioPlayer(contentsOf: url)
                player2.play()
            }
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cycle),  userInfo: nil, repeats: false)
        
        scoreLabel.text = "Score: \(score)"
    }
    
   
    
    @objc func cycle() {
     answerOneButton.backgroundColor = .secondarySystemBackground
     answerTwoButton.backgroundColor = .secondarySystemBackground
     
     if questionTrack + 1 < numberOfQuestions {
         
                questionTrack += 1
         let floatProgress = Float(questionTrack) / Float(numberOfQuestions)
        UIView.animate(withDuration: 0.8) {
                         self.questionProgress.setProgress(floatProgress, animated: true)
                     }

            } else {
                completeQuiz()
            }
     
     
        questionLabel.text = post?.questions[questionTrack].question
        answerOneButton.setTitle(post?.questions[questionTrack].answerOne, for: .normal)
        answerTwoButton.setTitle(post?.questions[questionTrack].answerTwo, for: .normal)
     }
   
   @objc func closeTapped() {
       self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
   }
    
    func buttonStyle(_ button: UIButton) {
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.minimumScaleFactor = 0.5;
        button.titleLabel?.adjustsFontSizeToFitWidth = true;
    }
    
    func openAlert() {
       var MYpopupView:CountDownViewController!
       MYpopupView = CountDownViewController(nibName:"CountDownViewController", bundle: nil)
       self.view.alpha = 1.0
        self.presentpopupViewController(popupViewController: MYpopupView, animationType: .Fade, completion: {() -> Void in
       })
       
   }
    
    func completeQuiz() {
        questionProgress.progress = 1
        
        if defaults.bool(forKey: "Sound") {
            guard let url = Bundle.main.url(forResource: "NewAch", withExtension: "wav") else { return }
            player2 = try! AVAudioPlayer(contentsOf: url)
            player2.play()
        }
        completeChart(likes: self.likes ?? 0, plays: self.plays ?? 0, score: self.score)
        
        db.collection("posts").document(post!.postID).collection("plays").document(userID!).setData(["userRef" : userID!]) { (error) in
            if let _ = error {

            }
        }
        
        db.collection("users").document(userID!).collection("scores").document("\(topicLabel.text!) \(usernameLabel.text!)").setData(["GameScore" : score])

    }
    
    @objc func completeChart(likes: Int, plays: Int, score: Int) {
        var MYpopupView:GameCompleteController!
        MYpopupView = GameCompleteController(nibName:"GameCompleteController", bundle: nil)
        self.view.alpha = 1.0
        MYpopupView.delegate = self
        MYpopupView.gameTitle = topicLabel.text
        MYpopupView.likes = likes
        MYpopupView.plays = plays
        MYpopupView.score = score
        MYpopupView.playOnce = playedOnceToRecieve
        MYpopupView.username = usernameLabel.text
        self.presentpopupViewController(popupViewController: MYpopupView, animationType: .Fade, completion: {() -> Void in
        })
        
    }
    
    func returnT() {
        
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
        self.navigationController?.popViewController(animated: false)
    }
    
    func extraT() {
        print("displaying ad")
        
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
        
        if self.rewardedAd?.isReady == true {
            self.rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
       self.navigationController?.popViewController(animated: false)
        
       
    }
    
    func playA() {
        print("resetting game")
        
        self.questionTrack = 0
        self.score = 0
        questionLabel.text = post?.questions[questionTrack].question
        self.answerOneButton.setTitle(post?.questions[questionTrack].answerOne, for: .normal)
        self.answerTwoButton.setTitle(post?.questions[questionTrack].answerTwo, for: .normal)
        
        self.scoreLabel.text = "Score: \(self.score)"
        self.questionProgress.progress = 0
        
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
    }
    
    //MARK: - reward ADs delegate
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
           print("15 xp earned")

        db.collection("users").document(userID!).collection("scores").document("\(topicLabel.text!) \(usernameLabel.text!)").setData(["Bonus" : 50], merge: true)
       }
    
    // Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
      print("Rewarded ad presented.")
    }
    // Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
       self.navigationController?.popViewController(animated: false)
        
    }
    // Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
      print("Rewarded ad failed to present.")
        self.navigationController?.popViewController(animated: false)
    }
    

}
