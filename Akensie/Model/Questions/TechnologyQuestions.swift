//
//  TechnologyQuestions.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 04/09/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation

struct TechnologyQuestions {
   static let easy: [EasyModel] = [
        

    EasyModel(question: "When was the first iPhone made?", answerOne: "2005", answerTwo: "2007", correctAnswer: "2007"),
    
    EasyModel(question: "Who developed the C programming language?", answerOne: "Linus Torvalds", answerTwo: "Dennis Ritchie", correctAnswer: "Dennis Ritchie"),
    
    EasyModel(question: "Amazon is the world’s largest internet retailer but when they first started what did they sell", answerOne: "Electronics", answerTwo: "Books", correctAnswer: "Books"),
    
    EasyModel(question: "What was the first phone to run Android", answerOne: "HTC Dream", answerTwo: "Nokia N80", correctAnswer: "HTC Dream"),
    
    EasyModel(question: "“People who are really serious about software should make their own hardware.” Who said this?", answerOne: "Elon Musk", answerTwo: "Alan Kay", correctAnswer: "Alan Kay"),
    
    EasyModel(question: "What is the unofficial name for Android’s green android robot mascot", answerOne: "Andy", answerTwo: "Bugdroid", correctAnswer: "Bugdroid"),
    
    EasyModel(question: "Who was the third founder of Apple computers Inc", answerOne: "Ronald Wayne", answerTwo: "Ron Howard", correctAnswer: "Ronald Wayne"),
    
    EasyModel(question: "How old was Mark Zuckerberg when he first started Facebook", answerOne: "21", answerTwo: "19", correctAnswer: "19"),
    
    EasyModel(question: "Mac OS versions are named after", answerOne: "Landmarks", answerTwo: "Rivers", correctAnswer: "Landmarks"),
    
    EasyModel(question: "Name the co-founder of Microsoft", answerOne: "Paul McCartney", answerTwo: "Paul Allen", correctAnswer: "Paul Allen"),
    
    // Not included questions
    
//    EasyModel(question: "JavaScript is an iteration of the Java programming language", answerOne: "True", answerTwo: "False", correctAnswer: "False"),
//
    EasyModel(question: "Hyperthreading technology was developed by", answerOne: "Intel", answerTwo: "NVIDIA", correctAnswer: "Intel"),
//
//    EasyModel(question: "UNIX is a type of...", answerOne: "Operating System", answerTwo: "Kernel", correctAnswer: "Operating System"),
//
//    EasyModel(question: "What is BASIC", answerOne: "A Programming Language", answerTwo: "A Backend Server", correctAnswer: "A Programming Language"),
//
//    EasyModel(question: "Why did Apple remove the headphone jack? ", answerOne: "For Wireless Technology", answerTwo: "For Waterproofing", correctAnswer: "For Wireless Technology"),
//
    EasyModel(question: "The G in GIGO stands for? ", answerOne: "Garbage", answerTwo: "Gigabyte", correctAnswer: "Garbage"),
//
    
//
    EasyModel(question: "Which company invented the GUI?", answerOne: "Xerox PARC", answerTwo: "Oracle Corp", correctAnswer: "Xerox PARC"),
//
//    EasyModel(question: "Who was the first to implement the GUI", answerOne: "Microsoft", answerTwo: "Apple", correctAnswer: "Apple"),
//
//    EasyModel(question: "Who is the current CEO of Google", answerOne: "Larry Page", answerTwo: "Sundar Pichai", correctAnswer: "Sundar Pichai")
    
    ]
    
    static let medium = [
        
        MediumModel(question: "This chinese company acquired IBM's personal computer business in 2005", answerOne: "Alibaba", answerTwo: "Xiaomi", answerThree: "Lenovo", answerFour: "Toshiba", correctAnswer: "Lenovo"),
        
        MediumModel(question: "In what year was Windows XP released", answerOne: "1995", answerTwo: "2001", answerThree: "2005", answerFour: "1997", correctAnswer: "2001"),
        
        MediumModel(question: "What does PNG stand for", answerOne: "Portable Network Graphics", answerTwo: "Progressive New Graphics", answerThree: "Pixels Neutral Gamma", answerFour: "Pre-Netscape Graphics", correctAnswer: "Portable Network Graphics"),
        
        MediumModel(question: "Who is the alleged creator of Bitcoin", answerOne: "Satoshi Nakamoto", answerTwo: "Steve Wozniak", answerThree: "Jack Ma", answerFour: "Ma Huateng", correctAnswer: "Satoshi Nakamoto"),
        
        MediumModel(question: "Which company developed the PDF file format", answerOne: "Microsoft", answerTwo: "Adobe", answerThree: "Apple", answerFour: "Sony", correctAnswer: "Adobe"),
        
        MediumModel(question: "Which of the following is a cofounder of pay pal", answerOne: "Martin Eberhard", answerTwo: "JB Straubel", answerThree: "Craig Federighi", answerFour: "Elon Musk", correctAnswer: "Elon Musk"),
        
        MediumModel(question: "Which of the following products was never released by Apple", answerOne: "PDA", answerTwo: "Game Console", answerThree: "Laser Printer", answerFour: "Projector", correctAnswer: "Game Console"),
        
        MediumModel(question: "LG is one of the biggest tech companies but what do the letters LG stand for", answerOne: "Long Gold", answerTwo: "Lasting Gadgets", answerThree: "", answerFour: "Life's Good", correctAnswer: "Life's Good"),
        
        MediumModel(question: "JPEGs are compressed images, but what do the letters stand for", answerOne: "Joint Picture Extra Graphics", answerTwo: "Jumbo Photos Exit Graphics", answerThree: "Japan Photography End Goals", answerFour: "Joint Photographic Experts Group", correctAnswer: "Joint Photographic Experts Group"),
        
        MediumModel(question: "1024 Gigabytes is equal to 1 Terabyte; 1024 Terabytes is equal to 1 Petabyte; How many Gigabytes are in a Petabyte?", answerOne: "2,048", answerTwo: "40,096", answerThree: "200,480", answerFour: "1,000,000", correctAnswer: "1,000,000")
    
    ]
    
    static let hard = [
        
        HardModel(question: "When the first production hard drive was shipped in 1957, what was its storage capacity", answerOne: "1.21 GB", answerTwo: "20 GB", answerThree: "3.75 MB", answerFour: "5 MB", correctAnswer: "3.75 MB"),
        
        HardModel(question: "Charles Babbage is known for creating the first... ?", answerOne: "Mechanical computer", answerTwo: "Calculator", answerThree: "Software language", answerFour: "Operating system", correctAnswer: "Mechanical computer"),
        
        HardModel(question: "Who is referred to as the father of the internet", answerOne: "Vint Cerf", answerTwo: "Bill Gates", answerThree: "Tim Bernes-Lee", answerFour: "Ada Lovelace", correctAnswer: "Vint Cerf"),
        
        HardModel(question: "Which company invented the hard disk drive?", answerOne: "IBM", answerTwo: "Hitachi", answerThree: "Fujitsu", answerFour: "Xerox", correctAnswer: "IBM"),
        
        HardModel(question: "Which of the following is not a version of WIFI", answerOne: "802.11a", answerTwo: "802.11b", answerThree: "802.11c", answerFour: "802.11ac", correctAnswer: "802.11c"),
        
        HardModel(question: "What does NTFS stand for", answerOne: "Non-Technical File Searching", answerTwo: "New Transactional File System", answerThree: "Non-Terminal File Security", answerFour: "New Technology File System", correctAnswer: "New Technology File System"),
        
        HardModel(question: "Which of the following is a lossless graphics format", answerOne: "FLAC", answerTwo: "JPG", answerThree: "PNG", answerFour: "PDF", correctAnswer: "PNG"),
        
        HardModel(question: "What is the maximum capacity of a 5.25” floppy disk", answerOne: "2 MB", answerTwo: "700 MB", answerThree: "360 KB", answerFour: "10 KB", correctAnswer: "360 KB"),
        
        HardModel(question: "What's the name of the landscape wallpaper that was a default on Windows XP?", answerOne: "Majesty", answerTwo: "Bliss", answerThree: "Happiness", answerFour: "Splendor", correctAnswer: "Bliss"),
        
        HardModel(question: "What did the ESP button do on portable CD players?", answerOne: "Shuffled your playlist", answerTwo: "Prevented songs from skipping", answerThree: "Changed your equalizer profile", answerFour: "Protected against electrostatic shock", correctAnswer: "Prevented songs from skipping"),
        
        
        // Not included
//        HardModel(question: "Which of the following was the first generation Raspberry Pi released in 2012", answerOne: "Raspberry Pi 1 Model A", answerTwo: "Raspberry Pi 1 Model B", answerThree: "Raspberry Pi Zero", answerFour: "Raspberry Pi 2", correctAnswer: "Raspberry Pi 1 Model B"),
        
    ]
}
