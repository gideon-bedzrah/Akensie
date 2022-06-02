//
//  AckViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 24/09/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import SafariServices
import AVKit

class AckViewController: UIViewController, UIScrollViewDelegate {

    let controller = AVPlayerViewController()
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nextButton.layer.cornerRadius = nextButton.frame.height / 2
        
        scrollView.delegate = self
    }
    

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
       
        
        if sender.currentTitle == "Next" {
            self.scrollToPage(page: self.page, animated: true)
            self.page += 1
        }else {
            
            if let url = URL(string: "https://akensie.com") {
                
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let safariVC = SFSafariViewController(url: url, configuration: config)
            
            self.present(safariVC, animated: true, completion: nil)
            
        }
        
        }
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
        
        if pageControl.currentPage == 0 {
            page = 1
            nextButton.setTitle("Next", for: .normal)
            self.title = "Appreciation"
            self.headerLabel.text = "Thank you for downloading Akensie!"
        } else if pageControl.currentPage == 1 {
            page = 2
            nextButton.setTitle("Next", for: .normal)
            self.title = "Akense's Mission"
            self.headerLabel.text = "Thank you for downloading Akensie!"
        }else if pageControl.currentPage == 2 {
            page = 3
            nextButton.setTitle("Go to", for: .normal)
            self.title = "Support Us"
            self.headerLabel.text = "Visit akensie.com"
        }
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func linkButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func playButtonTapped(_ sender: UIBarButtonItem) {
        
        let bundlePath = Bundle.main.path(forResource: "Buy Akensie", ofType: "mov")
        
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
         let item = AVPlayerItem(url: url)
        
       
        controller.player = AVPlayer(playerItem: item)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: controller.player?.currentItem)
       
        present(controller, animated: true) {
            self.controller.player?.play()
        }
    
    }
    
    @objc private func playerDidFinishPlaying() {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
