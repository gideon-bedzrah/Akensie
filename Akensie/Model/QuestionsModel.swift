//
//  QuestionsModel.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 18/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation


struct QuestionsModel {
    let easy: [EasyModel]
    let medium: [MediumModel]
    let hard: [HardModel]
}

struct EasyModel {
    var question: String
    var answerOne: String
    var answerTwo: String
    var correctAnswer: String
    
}

struct MediumModel {
    var question: String
    var answerOne: String
    var answerTwo: String
    var answerThree: String
    var answerFour: String
    var correctAnswer: String
    
    }

struct HardModel {
    var question: String
    var answerOne: String
    var answerTwo: String
    var answerThree: String
    var answerFour: String
    var correctAnswer: String
}


