//
//  HardViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 02/09/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation

class HardViewController: UIViewController, GADRewardedAdDelegate, GADInterstitialDelegate {

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
     var numberOfQuestions = 0
    //    let historyEasy = HistoryEasy()
        
        let userDefaults = UserDefaults.standard
        var score = 0
        
        var hardQuestions: [HardModel]? {
            didSet{
            if self.hardQuestions != nil {
                numberOfQuestions = self.hardQuestions!.count
            }
            }
        }
        
        var colors: UIColor!
        var bottom: UIImage!
        
        var hardScore: String?
        let hard = "hard"
        var categoryName: String!
        var questionTrack = 0
    
    var rewardedAd: GADRewardedAd?
    var interstitial: GADInterstitial!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        maxScore = numberOfQuestions * 5
        
        //interstitial ads
        let test = "ca-app-pub-3940256099942544/4411468910"
        let interstitialUnit = "ca-app-pub-4276347716468242/6948283666"
        interstitial = GADInterstitial(adUnitID: interstitialUnit)
        let request = GADRequest()
            interstitial.load(request)
        interstitial.delegate = self
        
        
        hardQuestions?.shuffle()
        
        questionView.layer.cornerRadius = 10
               answerView.layer.cornerRadius = 10
               
               questionProgress.progress = 0
               score = 0
               
               questionLabel.text = hardQuestions?[questionTrack].question
               answerButtonOne.setTitle(hardQuestions?[questionTrack].answerOne, for: .normal)
               answerButtonTwo.setTitle(hardQuestions?[questionTrack].answerTwo, for: .normal)
               answerButtonThree.setTitle(hardQuestions?[questionTrack].answerThree, for: .normal)
               answerButtonFour.setTitle(hardQuestions?[questionTrack].answerFour, for: .normal)
               
               buttonStyle(answerButtonOne)
               buttonStyle(answerButtonTwo)
               buttonStyle(answerButtonThree)
               buttonStyle(answerButtonFour)
               
               navigationController?.navigationBar.isHidden = true
               
               scoreLabel.text = "Score: \(score)"
               
                exitButton.isOpaque = true
        
        // View design
        questionView.backgroundColor = colors
        answerView.backgroundColor = colors
        
        //Google mobile ads
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
        
        if exitButton.isOpaque {
            if player != nil{
            player.pause()
            }
            self.navigationController?.popViewController(animated: false)
//            settings.playMusic(options: "Pause")
        }else {
            if player != nil{
            player.setVolume(0.4, fadeDuration: 0.3)
            }
            exitButton.alpha = 1
            exitButton.isOpaque = true
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
                // questions are done
                completeQuiz()
            }
     
        questionLabel.text = hardQuestions?[questionTrack].question
        answerButtonOne.setTitle(hardQuestions?[questionTrack].answerOne, for: .normal)
        answerButtonTwo.setTitle(hardQuestions?[questionTrack].answerTwo, for: .normal)
        answerButtonThree.setTitle(hardQuestions?[questionTrack].answerThree, for: .normal)
        answerButtonFour.setTitle(hardQuestions?[questionTrack].answerFour, for: .normal)
        
        
     }
    
    //MARK: - Answer button selected
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        
        exitButton.isOpaque = false
        exitButton.alpha = 0.2
        if player != nil {
        player.setVolume(1, fadeDuration: 0.3)
        }
         
        let userAnswer = sender.currentTitle!
        
        if userAnswer == hardQuestions?[questionTrack].correctAnswer {
            sender.buttonPulse()
            sender.backgroundColor = UIColor(hexString: "A3D68E")
            
            score += 5
            
            if defaults.bool(forKey: "Haptics") {
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
            
            if defaults.bool(forKey: "Haptics") {
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
    
    private func completeQuiz() {
        
        if player != nil{
    
            player.setVolume(0.4, fadeDuration: 0.3)
        }
        
        questionProgress.progress = 1
        
        if defaults.bool(forKey: "Sound") {
            guard let url = Bundle.main.url(forResource: "NewAch", withExtension: "wav") else { return }
            player2 = try! AVAudioPlayer(contentsOf: url)
            player2.play()
        }
        
        
        if userDefaults.integer(forKey: hardScore!) > score {
            // score is lower than existing score
            
            let lowerAlert = UIAlertController(title: "Try harder!", message: "You successfully completed the challenge but your score \(score) is lower than your previous \(userDefaults.integer(forKey: hardScore!)) score", preferredStyle: .alert)
            
            let nextAction = UIAlertAction(title: "Play Again", style: .default) {(tryAgain) in
                
                self.hardQuestions?.shuffle()
                self.questionTrack = 0
                self.score = 0
                self.questionLabel.text = self.hardQuestions?[self.questionTrack].question
                self.answerButtonOne.setTitle(self.hardQuestions?[self.questionTrack].answerOne, for: .normal)
                self.answerButtonTwo.setTitle(self.hardQuestions?[self.questionTrack].answerTwo, for: .normal)
                self.answerButtonThree.setTitle(self.hardQuestions?[self.questionTrack].answerThree, for: .normal)
                self.answerButtonFour.setTitle(self.hardQuestions?[self.questionTrack].answerFour, for: .normal)
                
                
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
            
            let adAction = UIAlertAction(title: "Watch Ad for +10 xp", style: .default) { (ad) in
                
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
        
            var achText: String = "Congratulations!"
            var message = "You have successfully completed the challenge."
            var added: String?
            
            
            if score == maxScore {
                
                var achType: String!
                var achName: String!
                added = "(+15)"
                switch categoryName {
                
                case Constants.categories.history :
                    achType = "You're a Historian!"
                    achName = Constants.categories.history
                case Constants.categories.art :
                    achType = "Professional Artist"
                    achName = Constants.categories.art
                case Constants.categories.business :
                    achType = "Investment Banker"
                    achName = Constants.categories.business
                case Constants.categories.popCulture :
                    achType = "Pop Culture Wiz"
                    achName = "Pop"
                case Constants.categories.technology :
                    achType = "Tech CEO"
                    achName = "Tech"
                default:
                    achType = ""
                    achName = ""
                }
                
                achText = "🎉 New achievement unlocked!"
                message = "\(achType!) has now been unlocked."
                UserAchievements.allAchievements(name: "all\(achName!)Hard")
            }
        
        let alert = UIAlertController(title: achText, message: "\(message) Your score is \(score) \(added ?? "")", preferredStyle: .alert)
        
        
        //Saving the score to firestore
            if added != nil {
               score = score + 15
            }
            
        GameScores.updateScore(category: categoryName, difficulty: hard, score: score)
        userDefaults.set(score, forKey: hardScore!)
        
        GameScores.totalScore()
        
        
        alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { [self] (return) in
            
            if player != nil{
            player.pause()
            }
            
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
              }
            self.navigationController?.popViewController(animated: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Watch Ad for +10 xp", style: .default, handler: { (ad) in
            
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
       let addedBonus = userDefaults.integer(forKey: "firstBonus") + 10
        
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
