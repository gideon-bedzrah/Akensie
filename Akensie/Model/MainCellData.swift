//
//  MainCellData.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 15/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

struct MainCellData {
    var myArray = [
        MainCellModel(title: Constants.categories.history, subtitle: "How much Ghanaian History do you really know?", image: "HistoryIG", accent: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), accentTwo: UIColor.systemGray3, question: QuestionsModel(easy: HistoryQuestions.easy, medium: HistoryQuestions.medium, hard: HistoryQuestions.hard), description: DescriptionData.history, easyScore: Constants.History.easyScore, mediumScore: Constants.History.mediumScore, hardScore: Constants.History.hardScore, colorRange: ColorsFromImage(image: UIImage(named: "HistoryIG")!, withFlatScheme: true), bottomFrame: UIImage(named: "PersonView")!, bonus: false),
        
        MainCellModel(title: Constants.categories.art, subtitle: "'If I could say it in words there would be no reason to paint'", image: "ArtIG", accent: #colorLiteral(red: 0.737254902, green: 0.3215686275, blue: 0.3215686275, alpha: 1), accentTwo: #colorLiteral(red: 0.737254902, green: 0.3215686275, blue: 0.3297556994, alpha: 1), question: QuestionsModel(easy: ArtQuestions.easy, medium: ArtQuestions.medium, hard: ArtQuestions.hard), description: DescriptionData.art, easyScore: Constants.Art.easyScore, mediumScore: Constants.Art.mediumScore, hardScore: Constants.Art.hardScore, colorRange: ColorsFromImage(image: UIImage(named: "ArtIG")!, withFlatScheme: false), bottomFrame: UIImage(named: "ArtView")!, bonus: false),
        
        
//        MainCellModel(title: Constants.categories.general, subtitle: "Are you up to date with current afairs in Ghana and Africa?", image: "GeneralIG", accent: #colorLiteral(red: 0.4117647059, green: 0.568627451, blue: 0.7490196078, alpha: 1), accentTwo: UIColor(averageColorFrom: UIImage(named: "GeneralIG")), question: QuestionsModel(easy: HistoryQuestions.easy, medium: HistoryQuestions.medium, hard: HistoryQuestions.hard), description: DescriptionData.general, easyScore: Constants.General.easyScore, mediumScore: Constants.General.mediumScore, colorRange: ColorsFromImage(image: UIImage(named: "GeneralIG")!, withFlatScheme: false), bottomFrame: UIImage(named: "PersonView")!),
        
        MainCellModel(title: Constants.categories.business, subtitle: "Do you really know as much as you think you know about business?", image: "BusinessIG", accent: #colorLiteral(red: 0.2862745098, green: 0.3725490196, blue: 0.3098039216, alpha: 1), accentTwo: UIColor(averageColorFrom: UIImage(named: "BusinessIG")), question: QuestionsModel(easy: BusinessQuestions.easy, medium: BusinessQuestions.medium, hard: BusinessQuestions.hard), description: DescriptionData.business, easyScore: Constants.Business.easyScore, mediumScore: Constants.Business.mediumScore, hardScore: Constants.Business.hardScore, colorRange: ColorsFromImage(image: UIImage(named: "BusinessIG")!, withFlatScheme: false), bottomFrame: UIImage(named: "BusinessView")!, bonus: true),
        
        MainCellModel(title: Constants.categories.popCulture, subtitle: "Know the Ins and Outs of Ghanaian culture? Prove it here", image: "PopCultureIG", accent: #colorLiteral(red: 0.003921568627, green: 0.5294117647, blue: 0.7529411765, alpha: 1), accentTwo: #colorLiteral(red: 0.003921568627, green: 0.5294117647, blue: 0.7529411765, alpha: 1), question: QuestionsModel(easy: PopcultureQuestions.easy, medium: PopcultureQuestions.medium, hard: PopcultureQuestions.hard), description: DescriptionData.popCulture, easyScore: Constants.PopCulture.easyScore, mediumScore: Constants.PopCulture.mediumScore, hardScore: Constants.PopCulture.hardScore, colorRange: ColorsFromImage(image: UIImage(named: "PopCultureIG")!, withFlatScheme: false), bottomFrame: UIImage(named: "PopView")!, bonus: false),
        
        MainCellModel(title: Constants.categories.technology, subtitle: "When was the first iPhone released? I think you should know", image: "TechnologyIG", accent: #colorLiteral(red: 0.5411764706, green: 0.5294117647, blue: 0.6078431373, alpha: 1), accentTwo: #colorLiteral(red: 0.5411764706, green: 0.5294117647, blue: 0.6078431373, alpha: 1), question: QuestionsModel(easy: TechnologyQuestions.easy, medium: TechnologyQuestions.medium, hard: TechnologyQuestions.hard), description: DescriptionData.technology, easyScore: Constants.Technology.easyScore, mediumScore: Constants.Technology.mediumScore, hardScore: Constants.Technology.hardScore, colorRange: ColorsFromImage(image: UIImage(named: "TechnologyIG")!, withFlatScheme: false), bottomFrame: UIImage(named: "TechView")!, bonus: true)
    ]
}
