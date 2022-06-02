//
//  ArtQuestions.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 30/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation

struct ArtQuestions {
    static let easy = [
        EasyModel(question: "Which of the following is the fourth highest earner of foreign exchange in Ghana?", answerOne: "Arts", answerTwo: "Tourism", correctAnswer: "Tourism"),
        
        EasyModel(question: "Which of the following musicians are considered one of the major proponents of the Azonto genre?", answerOne: "Guru", answerTwo: "R2bees", correctAnswer: "Guru"),
        
        EasyModel(question: "Which of the following dancers got featured in Beyonce and Shatta Wale’s music video, Already", answerOne: "Michael Amofa", answerTwo: "Laud Kojo Konadu", correctAnswer: "Laud Kojo Konadu"),
        
        EasyModel(question: "Which of the following celebrates Arts and Culture in Ghana?", answerOne: "Homowo", answerTwo: "Chale Wote", correctAnswer: "Chale Wote"),
        
        EasyModel(question: "The movie Kyeiwaa ends in which Part?", answerOne: "11", answerTwo: "13", correctAnswer: "11"),
        
        EasyModel(question: "Which music group recorded the popular “masan aba o” track?", answerOne: "Praye", answerTwo: "Akyeame", correctAnswer: "Akyeame"),
        
        EasyModel(question: "The movie Beast of No Nation featured which Ghanaian actor?", answerOne: "Idris Elba", answerTwo: "Will Smith", correctAnswer: "Idris Elba"),
        
        EasyModel(question: "Concert Party was sponsored by which brand?", answerOne: "Onga", answerTwo: "Keysoap", correctAnswer: "Keysoap"),
        
        EasyModel(question: "Advice was a diss song by Sarkodie directed at which musician?", answerOne: "Manifest", answerTwo: "Shatta Wale​", correctAnswer: "Shatta Wale​"),
        
        EasyModel(question: "Which Kumawood actor is popularly referred to as Bob Siga?", answerOne: "Kwaku Manu", answerTwo: "Agya Koo", correctAnswer: "Kwaku Manu"),
    ]
    
    static let medium = [
        MediumModel(question: "The phrase “Fa wo to begye golf” is associated with which former head of state of Ghana?", answerOne: "​IK Acheampong​", answerTwo: "JJ Rawlings", answerThree: "FWK Akuffo", answerFour: "KA Busia", correctAnswer: "​IK Acheampong​"),
        
        MediumModel(question: "Who is the host of the Real News on UTV?", answerOne: "Nana Ama McBrown", answerTwo: "Lil Wayne", answerThree: "Akrobeto", answerFour: "Ama Sarpong", correctAnswer: "Akrobeto"),
        
        MediumModel(question: "​“All sympathizers are cordially invited” is usually found on which of the following posters?", answerOne: "Birthday posters", answerTwo: "​Funeral​ posters", answerThree: "​Wedding​ posters", answerFour: "​Outreach​ posters", correctAnswer: "​Funeral​ posters"),
        
        MediumModel(question: "The popular statement “I can’t think far” was made by which of the following Kumawood actors?", answerOne: "​Lil Wayne", answerTwo: "Kwaku Manu", answerThree: "Santo", answerFour: "Bishop", correctAnswer: "​Lil Wayne"),
        
        MediumModel(question: "The chalewote festival is organized in which area in Accra?", answerOne: "Lapaz", answerTwo: "Dansoman", answerThree: "Nima", answerFour: "James Town", correctAnswer: "James Town"),
        
        MediumModel(question: "How can you fail?” is a phrase associated with which school?", answerOne: "Jackson College", answerTwo: "Ideal College", answerThree: "Smart College", answerFour: "Elite College", correctAnswer: "Ideal College"),
        
        MediumModel(question: "Who wrote the popular literature book, In the Chest of a woman?", answerOne: "Ebo Whyte", answerTwo: "Kofi Awoonor", answerThree: "Mawuli Adzei", answerFour: "Efo Kojo Mawugbe", correctAnswer: "Efo Kojo Mawugbe"),
        
        MediumModel(question: "The phrase ​“until the bones are rotten” ​is associated with which football club?", answerOne: "Kpando Hearts of Lions", answerTwo: "Bofoakwa Tano FC", answerThree: "Accra Hearts of Oak", answerFour: "Sekondi Hasaacas", correctAnswer: "Accra Hearts of Oak"),
        
        MediumModel(question: "“Woku apem aa apem b3ba” is the slogan of which football club in Ghana?", answerOne: "Medeama FC", answerTwo: "Sekondi Hasaacas", answerThree: "Accra Hearts of Oak", answerFour: "Asante Kotoko", correctAnswer: "Asante Kotoko"),
        
        MediumModel(question: "Among these options, what is the most popular inscription you will see at the back of trotros, taxis and shops?", answerOne: "In God we trust", answerTwo: "Don’t give up", answerThree: "Suro Nipa", answerFour: "Fear Delegates", correctAnswer: "In God we trust")
    ]
    
    static let hard = [
        HardModel(question: "Miracle Films is associated which of the following?", answerOne: "Kannywood", answerTwo: "Kumawood", answerThree: "Ghallywood", answerFour: "Nollywood", correctAnswer: "Kumawood"),
        
        HardModel(question: "Which year among these options did an eclipse of the sun in Ghana occur?", answerOne: "2006", answerTwo: "2011", answerThree: "2001", answerFour: "2005", correctAnswer: "2006"),
        
        HardModel(question: "​Which senior high school in Ghana has produced the most head of states?", answerOne: "Adisadel", answerTwo: "Prempeh College", answerThree: "Achimota", answerFour: "Mfantsipim School", correctAnswer: "Achimota"),
        
        HardModel(question: "Which of the following interchanges was popularly referred to as Dubai during it’s opening?", answerOne: "Ako Adjei Interchange", answerTwo: "Tetteh Quarshie Interchange", answerThree: "George W Bush", answerFour: "Circle Interchange", correctAnswer: "Circle Interchange"),
        
        //half mark
        
        HardModel(question: "Among these options, which American hiphop star dominates the posters put up in almost every barbership in Ghana", answerOne: "Ludacris", answerTwo: "Will Smith", answerThree: "Justin Bieber", answerFour: "Diddy", correctAnswer: "Ludacris"),
        
        HardModel(question: "Sarkodie’s Kanta was a reply to a beef song by Manifest called?", answerOne: "Suffer", answerTwo: "Forget Dem", answerThree: "Someway Bi", answerFour: "GODMC", correctAnswer: "GODMC"),
        
        HardModel(question: "Who wrote the popular literature book, In the Chest of a woman?", answerOne: "Ebo Whyte", answerTwo: "Mawuli Adzei", answerThree: "Efo Kojo Mawugbe", answerFour: "Kofi Awoonor", correctAnswer: "Efo Kojo Mawugbe"),
        
        HardModel(question: "Which school won the 2017 edition of the National Science and Maths Quiz?", answerOne: "Achimota School", answerTwo: "Adisadel College", answerThree: "St. Thomas Aquinas SHS", answerFour: "Prempeh college", correctAnswer: "Prempeh college"),
        
        HardModel(question: "Who is the host of the Real News on UTV?", answerOne: "Nana Ama McBrown", answerTwo: "Lil Wayne", answerThree: "Akrobeto", answerFour: "Ama Sarpong", correctAnswer: "Akrobeto"),
        
        HardModel(question: "In which suburb was H.E Nana Akufo-Addo was born?", answerOne: "Nima", answerTwo: "Swalaba", answerThree: "Legon", answerFour: "Madina", correctAnswer: "Swalaba")
    ]
}
