//
//  EasyViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 15/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import AVFoundation


class EasyViewController: UIViewController, GADRewardedAdDelegate, GADInterstitialDelegate {
    
   
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    
    @IBOutlet weak var questionProgress: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet weak var bottomDesign: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var timerProgress: UIProgressView!
    
    
    
    var numberOfQuestions = 0
    var player2: AVAudioPlayer!
    
    var maxScore: Int?
    
    let userDefaults = UserDefaults.standard
    var score = 0
    
    var easyQuestions: [EasyModel]? {
        didSet{
        if self.easyQuestions != nil {
            numberOfQuestions = self.easyQuestions!.count
        }
        }
    }

    let generator = UINotificationFeedbackGenerator()
    
//    var url: URL!
    
    var timerOne: Timer!
    var timerTwo: Timer!
    var timerThree: Timer!
    
    var colors: UIColor!
    var bottom: UIImage!
    
    var easyScore: String?
    let easy = "easy"
    var categoryName: String!
    var questionTrack = 0
    
    var interstitial: GADInterstitial!

    // initializing reward ad
    var rewardedAd: GADRewardedAd?
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calculating the max score achievements
        maxScore = numberOfQuestions * 5
        
//        print("Hello: \(defaults.string(forKey: "documentID")!)")

        // Interstitial
        let test = "ca-app-pub-3940256099942544/4411468910"
        let interstitialUnit = "ca-app-pub-4276347716468242/5986555783"
        interstitial = GADInterstitial(adUnitID: interstitialUnit)
        let request = GADRequest()
            interstitial.load(request)
        interstitial.delegate = self
        
        easyQuestions?.shuffle()
        
        buttonStyle(answerOneButton)
        buttonStyle(answerTwoButton)
        questionProgress.progress = 0
        navigationController?.navigationBar.isHidden = true
        
        // setting up the questions
        questionLabel.text = easyQuestions?[questionTrack].question
        answerOneButton.setTitle(easyQuestions?[questionTrack].answerOne, for: .normal)
        answerTwoButton.setTitle(easyQuestions?[questionTrack].answerTwo, for: .normal)
        
        scoreLabel.text = "Score: \(score)"
        
        
//        print(easyScore!)
        
        // Background view color and design
        questionView.backgroundColor = colors
        answerView.backgroundColor = colors
        questionView.layer.cornerRadius = 10
        answerView.layer.cornerRadius = 10
        bottomDesign.image = bottom
        questionLabel.textColor = .label
        
        
        //Google mobile ads
        let testAd = "ca-app-pub-3940256099942544/1712485313"
        let adUnit = "ca-app-pub-4276347716468242/6872262043"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if player != nil{
        player.setVolume(0.4, fadeDuration: 0.3)
        }
       
        if defaults.string(forKey: "Mode") == "Timed"{
        openAlert()
       timerOne = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(closeTapped), userInfo: nil, repeats: false)
            
        timerTwo =  Timer.scheduledTimer(timeInterval: 3.6, target: self, selector: #selector(timer), userInfo: nil, repeats: false)
            
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(resetBar), userInfo: nil, repeats: true)

        }
    }
    
     func openAlert() {
        var MYpopupView:CountDownViewController!
        MYpopupView = CountDownViewController(nibName:"CountDownViewController", bundle: nil)
        self.view.alpha = 1.0
//        MYpopupView.closePopup = self
        self.presentpopupViewController(popupViewController: MYpopupView, animationType: .TopTop, completion: {() -> Void in
        })
        
    }
    
    @objc func closeTapped() {
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        if timerOne != nil {
            timerOne.invalidate()
        }
        
        if timerTwo != nil {
            timerTwo.invalidate()
        }
        
        if timerThree != nil {
            timerThree.invalidate()
        }
        
    }
    
    @objc func timer() {
        timerThree = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(cycle),  userInfo: nil, repeats: true)
  
        UIView.animate(withDuration: 3) {
            self.timerProgress.setProgress(1, animated: true)
        }
        
//
        
//        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(resetBar), userInfo: nil, repeats: false)
        
//        let floatProgress = Float(questionTrack + 1) / Float(numberOfQuestions)
//       UIView.animate(withDuration: 0.8) {
//                        self.questionProgress.setProgress(floatProgress, animated: true)
//                    }
    }
    
    @objc func resetBar() {
        
        
    }
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        
        if exitButton.isOpaque == false {
            if player != nil{
            player.setVolume(0.4, fadeDuration: 0.3)
            }
            exitButton.alpha = 1
            exitButton.isOpaque = true
        }else{
            if player != nil{
            player.pause()
            }
            self.navigationController?.popViewController(animated: false)
        }
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
        self.timerProgress.setProgress(0, animated: false)
//        UIView.animate(withDuration: 3) {
//            self.timerProgress.setProgress(1, animated: true)
//        }
        
        
           } else {
               completeQuiz()
           }
    
    
    
    questionLabel.text = easyQuestions?[questionTrack].question
    answerOneButton.setTitle(easyQuestions?[questionTrack].answerOne, for: .normal)
    answerTwoButton.setTitle(easyQuestions?[questionTrack].answerTwo, for: .normal)
    }
//
    //MARK: - Answer button selected
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        exitButton.isOpaque = false
        exitButton.alpha = 0.2
        if player != nil {
        player.setVolume(1, fadeDuration: 0.3)
        }
        
        if timerTwo != nil {
            timerTwo.fire()
        }
        
        let userAnswer = sender.currentTitle!
        
        if userAnswer == easyQuestions?[questionTrack].correctAnswer {
            // haptics
            sender.buttonPulse()
            sender.backgroundColor = UIColor(hexString: "A3D68E")
                score += 5
            
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
    //MARK: - Complete Quiz Logic
    
    private func completeQuiz() -> Void {
        
        //Questions are done
        if player != nil{
            player.setVolume(0.4, fadeDuration: 0.3)
        }
        
        questionProgress.progress = 1
        if timerThree != nil {
            timerThree.invalidate()
        }
        
        if defaults.bool(forKey: "Sound") {
            guard let url = Bundle.main.url(forResource: "NewAch", withExtension: "wav") else { return }
            player2 = try! AVAudioPlayer(contentsOf: url)
            player2.play()
        }
        
        if userDefaults.integer(forKey: easyScore!) > score {
            // score is lower than existing score
            
                let lowerAlert = UIAlertController(title: "Try harder!", message: "You successfully completed the challenge but your score \(score) is lower than your previous \(userDefaults.integer(forKey: easyScore!)) score", preferredStyle: .alert)
                
                let nextAction = UIAlertAction(title: "Play Again", style: .default) {(tryAgain) in
                    
                    self.easyQuestions?.shuffle()
                    self.questionTrack = 0
                    self.score = 0
                    self.questionLabel.text = self.easyQuestions?[self.questionTrack].question
                    self.answerOneButton.setTitle(self.easyQuestions?[self.questionTrack].answerOne, for: .normal)
                    self.answerTwoButton.setTitle(self.easyQuestions?[self.questionTrack].answerTwo, for: .normal)
                    
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.questionProgress.progress = 0
                    
                    if player != nil {
                    player.setVolume(1, fadeDuration: 0.3)
                    }
                }
                
                let returnAction = UIAlertAction(title: "Return", style: .default) { (return) in
                    
                    if player != nil{
                    player.pause()
                    }
                    
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                      }
                     self.navigationController?.popViewController(animated: false)
                }
                
                let adAction = UIAlertAction(title: "Watch Ad for +5 xp", style: .default) { (ad) in
                    
                    if player != nil{
                    player.pause()
                    }
                    
                    if self.rewardedAd?.isReady == true {
                         self.rewardedAd?.present(fromRootViewController: self, delegate:self)
                     }
                    self.navigationController?.popViewController(animated: false)
                }
                
                lowerAlert.addAction(nextAction)
                lowerAlert.addAction(returnAction)
                lowerAlert.addAction(adAction)
                self.present(lowerAlert, animated: true, completion: nil)
                
            } else {
               
                //Present a UI Alert to congratulate user
                
                var achText: String = "Congratulations!"
                var message = "You have successfully completed the challenge."
                var added: String?
                
                if score == maxScore {
                
                    var achType: String!
                    var achName: String!
                    added = "(+5)"
                    switch categoryName {
                    
                    case Constants.categories.history :
                        achType = "Learning History"
                        achName = Constants.categories.history
                    case Constants.categories.art :
                        achType = "Almost an Artist"
                        achName = Constants.categories.art
                    case Constants.categories.business :
                        achType = "Emerging Manager!"
                        achName = Constants.categories.business
                    case Constants.categories.popCulture :
                        achType = "Pop Artist"
                        achName = "Pop"
                    case Constants.categories.technology :
                        achType = "Dreamer"
                        achName = "Tech"
                    default:
                        achType = ""
                        achName = ""
                    }
                    
                    achText = "🎉 New achievement unlocked!"
                    message = "\(achType!) has now been unlocked."
                    UserAchievements.allAchievements(name: "all\(achName!)Easy")
                }
                
                let alert = UIAlertController(title: achText, message: "\(message) Your score is \(score) \(added ?? "")", preferredStyle: .alert)
                         
                         
                         // Saving the score to firestore
                         
                if added != nil {
                   score = score + 5
                }
                         GameScores.updateScore(category: categoryName, difficulty: easy, score: score)
                         userDefaults.set(score, forKey: easyScore!)
                         
                         GameScores.totalScore()
                         
                let action = UIAlertAction(title: "Return", style: .default) { [self] (action) in
                    
                    if player != nil{
                    player.pause()
                    }
                            if interstitial.isReady {
                                interstitial.present(fromRootViewController: self)
                              }
                             self.navigationController?.popViewController(animated: false)
                         }
                         
                         let videoAction = UIAlertAction(title: "Watch Ad for +5 xp", style: .default) { (action) in
                             
                            if player != nil{
                            player.pause()
                            }
                            
                             //reward ad
                             if self.rewardedAd?.isReady == true {
                                 self.rewardedAd?.present(fromRootViewController: self, delegate:self)
                             }
                            self.navigationController?.popViewController(animated: false)
                         }
                         
                         //hide home indicator
                         
                         alert.addAction(action)
                         alert.addAction(videoAction)
                         self.present(alert, animated: true, completion: nil)
            }
            
         
    }
    
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    
    //MARK: - reward ADs delegate
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
           print("15 xp earned")
       let addedBonus = userDefaults.integer(forKey: "firstBonus") + 5
        
        userDefaults.set(addedBonus, forKey: "firstBonus")
        GameScores.updateBonus(bonusScore: addedBonus)
        GameScores.totalScore()
        

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
       
    
    
    
    //MARK: - styling the answer buttons
    
    func buttonStyle(_ button: UIButton) {
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.minimumScaleFactor = 0.5;
        button.titleLabel?.adjustsFontSizeToFitWidth = true;
    }

   
}

extension UIButton {
    
    func buttonShake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
    
    func buttonPulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.autoreverses = false
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        
        layer.add(pulse, forKey: nil)
    }
}
