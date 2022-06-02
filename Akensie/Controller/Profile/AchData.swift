//
//  AchData.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 18/11/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation

struct AchModel {
    let name: String
    let image: String
    let text: String
    let description: String
    
}

struct AchievementModel {
    let text: String
    let image: String
    let description: String
    let points: Int
}

struct AchData {
    static let achData: [AchModel] = [
        
        AchModel(name: "allHistoryEasy", image: "allHistoryEasy", text: "Learning History", description: ""),
        
        AchModel(name: "allHistoryMedium", image: "allHistoryMedium", text: "Dr. Osagyefo", description: ""),
        
        AchModel(name: "allHistoryHard", image: "allHistoryHard", text: "You're a Historian!", description: ""),
        
        AchModel(name: "allArtEasy", image: "allArtEasy", text: "Almost an Artist", description: ""),
        
        AchModel(name: "allArtMedium", image: "allArtMedium", text: "Keep up the Artistry", description: ""),
        
        AchModel(name: "allArtHard", image: "allArtHard", text: "Professional Artist", description: ""),
        
        AchModel(name: "allPopEasy", image: "allPopEasy", text: "Pop Culture Novice", description: ""),
        
        AchModel(name: "allPopMedium", image: "allPopMedium", text: "Above Novice", description: ""),
        
        AchModel(name: "allPopHard", image: "allPopHard", text: "Pop Culture Wiz", description: ""),
        
        AchModel(name: "allBusinessEasy", image: "allBusinessEasy", text: "Emerging Manager!", description: ""),
        
        AchModel(name: "allBusinessMedium", image: "allBusinessMedium", text: "CEO", description: ""),
        
        AchModel(name: "allBusinessHard", image: "allBusinessHard", text: "Investment Banker", description: ""),
        
        AchModel(name: "allTechEasy", image: "allTechEasy", text: "Dreamer", description: ""),
        
        AchModel(name: "allTechMedium", image: "allTechMedium", text: "Innovator", description: ""),
        
        AchModel(name: "allTechHard", image: "allTechHard", text: "Tech CEO", description: ""),
        
        AchModel(name: "threeXP", image: "threeXP", text: "You're on a roll", description: ""),
        
        AchModel(name: "newProfile", image: "newProfile", text: "Shiny new look", description: "Set a new profile image")
        
    ]
}
