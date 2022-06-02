//
//  EasyModel.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 18/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation

struct EasyModel {
    var question: String
    var answerOne: String
    var answerTwo: String
    
    init(question: String, answerOne: String, answerTwo: String) {
        self.question = question
        self.answerOne = answerOne
        self.answerTwo = answerTwo
    }
}
