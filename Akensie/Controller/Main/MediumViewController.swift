//
//  MediumViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 18/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation

class MediumViewController: UIViewController, GADRewardedAdDelegate, GADInterstitialDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgress: UIProgressView!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var questionView: UIView!
    
    @IBOutlet weak var answerView: UIView!
    
    let generator = UINotificationFeedbackGenerator()
    
    var maxScore: Int?
    var player2: AVAudioPlayer!
    
    let userDefaults = UserDefaults.standard
    
    var numberOfQuestions = 0
    
    var mediumQuestions: [MediumModel]? {
        didSet{
            if self.mediumQuestions != nil {
                numberOfQuestions = self.mediumQuestions!.count
            }
        }
    }
    
    
    
    let medium = "medium"
    
    var mediumScore: String?
    
    var categoryName: String!
    
    var questionTrack = 0
    
    var score = 0
    var colors: UIColor!
    
      var rewardedAd: GADRewardedAd?
    var interstitial: GADInterstitial!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        maxScore = numberOfQuestions * 5
        
        //interstitial ads
        let test = "ca-app-pub-3940256099942544/4411468910"
        let interstitialUnit = "ca-app-pub-4276347716468242/6680690350"
        interstitial = GADInterstitial(adUnitID: interstitialUnit)
        let request = GADRequest()
            interstitial.load(request)
        interstitial.delegate = self
        
        mediumQuestions?.shuffle()
        
        // view design
        questionView.layer.cornerRadius = 10
        answerView.layer.cornerRadius = 10
        
        questionView.backgroundColor = colors
        answerView.backgroundColor = colors
        
        questionProgress.progress = 0
        score = 0
        
        questionLabel.text = mediumQuestions?[questionTrack].question
        answerButtonOne.setTitle(mediumQuestions?[questionTrack].answerOne, for: .normal)
        answerButtonTwo.setTitle(mediumQuestions?[questionTrack].answerTwo, for: .normal)
        answerButtonThree.setTitle(mediumQuestions?[questionTrack].answerThree, for: .normal)
        answerButtonFour.setTitle(mediumQuestions?[questionTrack].answerFour, for: .normal)
        
        buttonStyle(answerButtonOne)
        buttonStyle(answerButtonTwo)
        buttonStyle(answerButtonThree)
        buttonStyle(answerButtonFour)
        
        navigationController?.navigationBar.isHidden = true
        
        scoreLabel.text = "Score: \(score)"
        
        //Google mobile ads
        let testUnit = "ca-app-pub-3940256099942544/1712485313"
        let adUnit = "ca-app-pub-4276347716468242/2166235437"
        
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
           navigationController?.navigationBar.isHidden = false
       }
    
  
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        
        if exitButton.isOpaque == false {
            if player != nil{
            player.setVolume(0.4, fadeDuration: 0.3)
            }
            exitButton.isOpaque = true
            exitButton.alpha = 1
        }else {
            if player != nil{
            player.pause()
            }
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: - Cycle through questions
    @objc func cycle() {
     answerButtonOne.backgroundColor = .tertiarySystemGroupedBackground
     answerButtonTwo.backgroundColor = .tertiarySystemGroupedBackground
    answerButtonThree.backgroundColor = .tertiarySystemGroupedBackground
    answerButtonFour.backgroundColor = .tertiarySystemGroupedBackground
     
     if questionTrack + 1 < numberOfQuestions {
                questionTrack += 1
     
            } else {
                completeQuiz()
            }
     
        questionLabel.text = mediumQuestions?[questionTrack].question
        answerButtonOne.setTitle(mediumQuestions?[questionTrack].answerOne, for: .normal)
        answerButtonTwo.setTitle(mediumQuestions?[questionTrack].answerTwo, for: .normal)
        answerButtonThree.setTitle(mediumQuestions?[questionTrack].answerThree, for: .normal)
        answerButtonFour.setTitle(mediumQuestions?[questionTrack].answerFour, for: .normal)
        
        
     }
    
    //MARK: - Answer button selected
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        exitButton.isOpaque = false
        exitButton.alpha = 0.2
        if player != nil {
        player.setVolume(1, fadeDuration: 0.3)
        }
        
        let userAnswer = sender.currentTitle!
        
        if userAnswer == mediumQuestions?[questionTrack].correctAnswer {
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
            sender.backgroundColor = UIColor(hexString: "FC7D7D")
            sender.buttonShake()
            
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
        
        let floatProgress = Float(questionTrack + 1) / Float(numberOfQuestions)
        UIView.animate(withDuration: 0.8) {
            self.questionProgress.setProgress(floatProgress, animated: true)
        }
        
        scoreLabel.text = "Score: \(score)"
        
    }
    
    //MARK: - Complete Quiz Logic
    
   private func completeQuiz() -> Void {
    
            questionProgress.progress = 1
    if player != nil{
    player.setVolume(0.4, fadeDuration: 0.3)
    }
    
    if defaults.bool(forKey: "Sound") {
        guard let url = Bundle.main.url(forResource: "NewAch", withExtension: "wav") else { return }
        player2 = try! AVAudioPlayer(contentsOf: url)
        player2.play()
    }
    
    
    if userDefaults.integer(forKey: mediumScore!) > score {
        // score is lower than existing score
        
        let lowerAlert = UIAlertController(title: "Try harder!", message: "You successfully completed the challenge but your score \(score) is lower than your previous \(userDefaults.integer(forKey: mediumScore!)) score", preferredStyle: .alert)
        
        let nextAction = UIAlertAction(title: "Play Again", style: .default) {(tryAgain) in
            
            self.mediumQuestions?.shuffle()
            self.questionTrack = 0
            self.score = 0
            self.questionLabel.text = self.mediumQuestions?[self.questionTrack].question
            self.answerButtonOne.setTitle(self.mediumQuestions?[self.questionTrack].answerOne, for: .normal)
            self.answerButtonTwo.setTitle(self.mediumQuestions?[self.questionTrack].answerTwo, for: .normal)
            self.answerButtonThree.setTitle(self.mediumQuestions?[self.questionTrack].answerThree, for: .normal)
            self.answerButtonFour.setTitle(self.mediumQuestions?[self.questionTrack].answerFour, for: .normal)
            
            
            self.scoreLabel.text = "Score: \(self.score)"
            self.questionProgress.progress = 0
            
            if player != nil {
            player.setVolume(1, fadeDuration: 0.3)
            }
        }
        
        let returnAction = UIAlertAction(title: "Return", style: .default) { [self] (return) in
            
            if player != nil{
            player.pause()
            }
            
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
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
            added = "(+10)"
            switch categoryName {
            
            case Constants.categories.history :
                achType = "Dr. Osagyefo"
                achName = Constants.categories.history
            case Constants.categories.art :
                achType = "Keep up the Artistry"
                achName = Constants.categories.art
            case Constants.categories.business :
                achType = "CEO!"
                achName = Constants.categories.business
            case Constants.categories.popCulture :
                achType = "Above Novice"
                achName = "Pop"
            case Constants.categories.technology :
                achType = "Innovator"
                achName = "Tech"
            default:
                achType = ""
                achName = ""
            }
            
            achText = "🎉 New achievement unlocked!"
            message = "\(achType!) has now been unlocked."
            UserAchievements.allAchievements(name: "all\(achName!)Medium")
        }
    
            let alert = UIAlertController(title: achText, message: "\(message) Your score is \(score) \(added ?? "")", preferredStyle: .alert)
            
            
            // Saving the score to firestore
        if added != nil {
           score = score + 10
        }
        
            GameScores.updateScore(category: categoryName, difficulty: medium, score: score)
            userDefaults.set(score, forKey: mediumScore!)
            
            GameScores.totalScore()
            
            let action = UIAlertAction(title: "Return", style: .default) { [self] (action) in
                
                if player != nil{
                player.pause()
                }
                
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: self)
                  }
                
                //interstitial ad
                self.navigationController?.popViewController(animated: false)
                
                //hide home indicator
                
            }
            alert.addAction(action)
         
         alert.addAction(UIAlertAction(title: "Watch Ad for +5 xp", style: .default, handler: { (ad) in
            
            if player != nil{
            player.pause()
            }
            
             if self.rewardedAd?.isReady == true {
                  self.rewardedAd?.present(fromRootViewController: self, delegate:self)
              }
             self.navigationController?.popViewController(animated: false)
         }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - reward ADs delegate
       
       func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
              print("10 xp earned")
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
          
       
    
    func buttonStyle(_ button: UIButton) {
          button.layer.cornerRadius = 12
          button.layer.borderColor = UIColor.black.cgColor
          button.layer.borderWidth = 2
          button.titleLabel?.minimumScaleFactor = 0.5;
          button.titleLabel?.adjustsFontSizeToFitWidth = true;
      }
    
}
