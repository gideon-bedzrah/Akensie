//
//  LeaderboardModel.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 21/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation

struct LeaderboardModel {
    let name: String
    let username: String
    let score: Int
    let pic: String
    let docId: String
    let position: Int
}

struct CompleteProfile {
    let name, username: String
    let score: Int
    let pic: String
    let scoreBreakdown: [ScoreBreakdown]
    let achievement: [AchievementModel]
}

struct ScoreBreakdown {
    let subject: String
    let easy: Int
    let medium: Int
    let Hard: Int
}
