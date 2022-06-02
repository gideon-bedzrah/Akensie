//
//  File.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 10/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import Foundation

//struct Posts: Codable {
//    let title: String
//    let caption: String
//    let questionNumber: Int
//    let time: String
//    let image: String
//    let userfullname: String
//    let userUsername: String
//}

public struct NewPosts: Codable {
    let title: String
    let caption: String
    let time: Date
    let image: String
    let posterID: String
    let likesCount: Int
    let postID: String
    let playsCount: Int
    let userfullname: String
    let userUsername: String
    let playOnce: Bool
    let questions: [NewQuestion]
    
    enum CodingKeys: String, CodingKey {
        case title
        case caption
        case time
        case image
        case posterID
        case likesCount
        case postID
        case playsCount
        case userfullname
        case userUsername
        case playOnce
        case questions
    }
}

public struct NewQuestion: Codable {
    let question: String
    let answerOne: String
    let answerTwo: String
    let correctAnswer: String
    
    enum CodingKeys: String, CodingKey {
        case question
        case answerOne
        case answerTwo
        case correctAnswer
    }
}

struct Users: Codable {
    let fullName: String
    let username: String
    let score: Int
    let uid: String
    let profilePic: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full name"
        case username
        case score
        case uid
        case profilePic
    }
}

struct PostCell {
    let nPost: NewPosts
    let user: Users
    let time: Date
}
