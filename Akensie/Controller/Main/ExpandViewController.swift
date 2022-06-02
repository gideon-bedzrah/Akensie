//
//  ExpandViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 14/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import GoogleMobileAds
//appID = ca-app-pub-4276347716468242~9915840357
import AVFoundation
var player: AVAudioPlayer!


class ExpandViewController: UIViewController, GameModeDelegate {
    func normalTapped() {
        print("hello")
    }
    

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var backCard: UIView!
    @IBOutlet weak var seperator: UIView!
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var player2: AVAudioPlayer!
    var selectedCell: MainCellModel?
    
    var number = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedCell?.title == Constants.categories.history {
            if defaults.bool(forKey: "Music"){
                guard let url = Bundle.main.url(forResource: "07 Ghana Freedom Highlife", withExtension: "mp3") else { return }
                
                player = try! AVAudioPlayer(contentsOf: url)
                player.numberOfLoops = 7
            }else {
                player = nil
            }
        }else{
            player = nil
        }
        
        
        
        let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
        
        
        
        if let passedCell = selectedCell {
            largeImage.image = UIImage(named: passedCell.image)
            // pass description as well
            descriptionLabel.text = passedCell.description
            
            //set the accent color properties
            backCard.backgroundColor = passedCell.accentTwo
            descriptionLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: selectedCell?.accentTwo, isFlat: true)
            difficultyLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: selectedCell?.accentTwo, isFlat: true)
            seperator.backgroundColor = UIColor(contrastingBlackOrWhiteColorOn: selectedCell?.accentTwo, isFlat: true)
            
            // don't forget to change the ad ID
            
            
            let testUnit = "ca-app-pub-3940256099942544/2934735716"
            let adUnit = "ca-app-pub-4276347716468242/8184848875"
            
            bannerView.adSize = adSize
            bannerView.adUnitID = adUnit
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            
        }
        
        
        
        shadowEffect(easyButton)
        shadowEffect(mediumButton)
        shadowEffect(hardButton)
        shadowEffect(largeImage)
        
        let profileIcon = UIButton()
        profileIcon.setImage(UIImage(systemName: "gamecontroller.fill"), for: .normal)
        profileIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        profileIcon.addTarget(self, action: #selector(leaderName), for: .touchUpInside)
        profileIcon.contentMode = .scaleToFill
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileIcon)
        
        
        
        
        
        switch number {
        case 1:
            easySelection()
        case 2:
            mediumSelection()
        case 3:
            hardSelection()
        default:
            print("Difficulty out of range")
        }
       
        
    }
    
    @objc func openAlert() {
        var MYpopupView:GameModePopUp!
        MYpopupView = GameModePopUp(nibName:"GameModePopUp", bundle: nil)
        self.view.alpha = 1.0
//        MYpopupView.closePopup = self
        self.presentpopupViewController(popupViewController: MYpopupView, animationType: .TopTop, completion: {() -> Void in
        })
        
    }
    
   @objc func leaderName() {
        let alert = UIAlertController(title: "Select a Game Mode", message: "Coming Soon", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Setting the navigation bar properties
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
      
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .none
        
    }
    
    
    
    @IBAction func beginButtonTapped(_ sender: UIButton) {
        
        if player != nil{
            player.play()
        }
        
        if selectedCell?.title == Constants.categories.history {
            if defaults.bool(forKey: "Sound") {
                guard let url = Bundle.main.url(forResource: "BeginSound", withExtension: "wav") else { return }
                player2 = try! AVAudioPlayer(contentsOf: url)
                player2.play()
            }
        }else {
            if defaults.bool(forKey: "Sound") {
                guard let url = Bundle.main.url(forResource: "BeginTwo", withExtension: "wav") else { return }
                player2 = try! AVAudioPlayer(contentsOf: url)
                player2.play()
            }
        }
        
        
        
        if easyButton.isSelected {
            performSegue(withIdentifier: "toEasy", sender: self)
        }else if mediumButton.isSelected {
            performSegue(withIdentifier: "toMedium", sender: self)
        }else if hardButton.isSelected {
            performSegue(withIdentifier: "toHard", sender: self)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEasy":
            let destinationVC = segue.destination as! EasyViewController
            destinationVC.easyQuestions = selectedCell?.question.easy
            destinationVC.easyScore = selectedCell?.easyScore
            destinationVC.categoryName = selectedCell?.title
            destinationVC.colors = selectedCell?.accentTwo
            destinationVC.bottom = selectedCell?.bottomFrame
            
        case "toMedium":
            let destinationVC = segue.destination as! MediumViewController
            destinationVC.mediumQuestions = selectedCell?.question.medium
            destinationVC.mediumScore = selectedCell?.mediumScore
            destinationVC.categoryName = selectedCell?.title
            destinationVC.colors = selectedCell?.accentTwo
            
        case "toHard":
            let destinationVC = segue.destination as! HardViewController
            destinationVC.categoryName = selectedCell?.title
            destinationVC.hardQuestions = selectedCell?.question.hard
            destinationVC.hardScore = selectedCell?.hardScore
            destinationVC.colors = selectedCell?.accentTwo
        default:
            print("no data was passed")
        }
    }
    
    
    func shadowEffect(_ view: UIView) {
        view.layer.cornerRadius = 0
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
    }

    @IBAction func diffButtonTapped(_ sender: UIButton) {
        
        if defaults.bool(forKey: "Haptics") {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        if defaults.bool(forKey: "Sound") {
            guard let url = Bundle.main.url(forResource: "DifficultyChanged", withExtension: "wav") else { return }
            player2 = try! AVAudioPlayer(contentsOf: url)
            player2.play()
        }
            
        if sender == easyButton {
            easySelection()
            number = 1
        } else if sender == mediumButton {
            mediumSelection()
            number = 2
        }else if sender == hardButton {
            hardSelection()
            number = 3
        }
        
        print(number)
    }
    
    func easySelection() {
        easyButton.isSelected = true
        mediumButton.isSelected = false
        hardButton.isSelected = false
        
        easyButton.setTitleColor(.white, for: .selected)
        mediumButton.setTitleColor(.black, for: .normal)
        hardButton.setTitleColor(.black, for: .normal)
        
        
        easyButton.backgroundColor = .black
        mediumButton.backgroundColor = .white
        hardButton.backgroundColor = .white
        
        difficultyLabel.text = "Ease in, for simpler, less detail-oriented questions"
    }
    
    func mediumSelection() {
        easyButton.isSelected = false
        mediumButton.isSelected = true
        hardButton.isSelected = false
        
        easyButton.setTitleColor(.black, for: .normal)
        mediumButton.setTitleColor(.white, for: .selected)
        hardButton.setTitleColor(.black, for: .normal)
        
        
        easyButton.backgroundColor = .white
        mediumButton.backgroundColor = .black
        hardButton.backgroundColor = .white
        
        difficultyLabel.text = "Get comfortable with questions which require a bit of thinking"
    }
    
    func hardSelection() {
        easyButton.isSelected = false
        mediumButton.isSelected = false
        hardButton.isSelected = true
        
        easyButton.setTitleColor(.black, for: .normal)
        mediumButton.setTitleColor(.black, for: .normal)
        hardButton.setTitleColor(.white, for: .selected)
        
        
        easyButton.backgroundColor = .white
        mediumButton.backgroundColor = .white
        hardButton.backgroundColor = .black

        difficultyLabel.text = "Hmm… these questions would rock your brain"
    }
        
    
}
