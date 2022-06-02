//
//  SplashViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 20/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, UIScrollViewDelegate {

    var window: UIWindow?
   let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var descriptionText: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //hidden elements
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var accountStack: UIStackView!
    
    @IBOutlet weak var signButton: UIButton!
    
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scrollView.delegate = self
        // Do any additional setup after loading the view.
        signButton.setTitle("Continue", for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        if sender.currentTitle != "Sign up to play" {
            self.scrollToPage(page: self.page, animated: true)
            self.page += 1
        }else {
            
            performSegue(withIdentifier: "signin", sender: self)
        }
        
    }
    
    
    @IBAction func noSignInButtonTapped(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "No Sign-In", message: "You will not be able to view user posts or access the global leaderboard", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (continue) in
            print("Logging in")
            
            defaults.set(true, forKey: "Haptics")
            defaults.set(true, forKey: "Sound")
            defaults.set(true, forKey: "Music")
            defaults.set(true, forKey: "Position")
            defaults.set(false, forKey: "Akan")
            
            let hVC = self.storyboard?.instantiateViewController(identifier: "WelcomeHome")
            self.view.window?.rootViewController = hVC
            self.view.window?.makeKeyAndVisible()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
        
        if pageControl.currentPage == 0 {
            descriptionText.text = "Learn more about which events and people shaped Ghana."
            page = 1
            signButton.setTitle("Continue", for: .normal)
        } else if pageControl.currentPage == 1 {
            descriptionText.text = "Explore popular categories handpicked by the very best."
            page = 2
            signButton.setTitle("Continue", for: .normal)
        }else if pageControl.currentPage == 2 {
            descriptionText.text = "Compete to be on top with live leaderboard updates and challenges."
            page = 3
            continueButton.isHidden = false
            signButton.setTitle("Sign up to play", for: .normal)
        }
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    

}
