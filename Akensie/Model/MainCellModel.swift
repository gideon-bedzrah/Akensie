//
//  MainCell.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 14/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct MainCellModel {
    var title: String
    var subtitle: String
    var image: String
    var accent: UIColor
    
    var accentTwo: UIColor
    var question: QuestionsModel
    var description: String
    
    var easyScore: String
    var mediumScore: String
    var hardScore: String
    
    var colorRange: [UIColor]
    var bottomFrame: UIImage
    
    var bonus: Bool
}

//struct Score1 {
//
//}
