//
//  AllSettings.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 20/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AllSettings {
    
    var player: AVAudioPlayer!
    
    func playMusic(options: String) {
        
        if defaults.bool(forKey: "Music") {
            
            guard let url = Bundle.main.url(forResource: "07 Ghana Freedom Highlife", withExtension: "mp3") else { return }

            player = try! AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = 3
            
            if options == "Play" {
//
                player.setVolume(1.0, fadeDuration: 10)
                player.play()
            }else {
                player.setVolume(0.8, fadeDuration: 2)
                player.play()
            }
           
        }
    }
    
}
