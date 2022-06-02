//
//  HistoryQuestions.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 18/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct HistoryQuestions {
    static let easy: [EasyModel] = [
        
        EasyModel(question: "In what year did Ghana gain Independence", answerOne: "1960", answerTwo: "1957", correctAnswer: "1957"),
        
        EasyModel(question: "Who staged Ghana’s first palace coup", answerOne: "Lt. General Fred Akuffo​", answerTwo: "Gen IK Acheampong", correctAnswer: "Lt. General Fred Akuffo​"),
        
        // question 1
        EasyModel(question: "Who was the last Governor - General of Ghana?", answerOne: "​Lord Listowell", answerTwo: "Sir C. N. Arden-Clarke", correctAnswer: "​Lord Listowell"),
        
        
        EasyModel(question: "Which personality earned the title “Doyen of Gold Coast Politics”?", answerOne: "Kwame Nkrumah", answerTwo: "JB Danquah", correctAnswer: "JB Danquah"),
        
        EasyModel(question: "Under which President was the Akosombo Dam built?", answerOne: "Kwame Nkrumah", answerTwo: "KA Busia", correctAnswer: "Kwame Nkrumah"),
        
        EasyModel(question: "Who were the first Europeans to land on the Gold Coast?", answerOne: "Danes", answerTwo: "Portuguese", correctAnswer: "Portuguese"),
        
        EasyModel(question: "In which year was Nkrumah made Leader of Government Business?", answerOne: "1952", answerTwo: "1957", correctAnswer: "1952"),
        
        EasyModel(question: "First secondary school in Ghana?", answerOne: "Mfantsipim​", answerTwo: "Achimota", correctAnswer: "Mfantsipim​"),
        
        EasyModel(question: "In which year was the CPP formed?", answerOne: "1949", answerTwo: "1946", correctAnswer: "1949"),
        
        EasyModel(question: "Who won the Sagrenti War?", answerOne: "Asante", answerTwo: "British", correctAnswer: "British"),
        
        EasyModel(question: "Who was the first African Chief Justice of the Gold Coast?", answerOne: "Sir Arku Korsah", answerTwo: "Sir Emmanuel Quist", correctAnswer: "Sir Arku Korsah"),
        
        EasyModel(question: "In which year was the UGCC formed?", answerOne: "1946", answerTwo: "1947", correctAnswer: "1947"),
        
        //question 12
        
        EasyModel(question: "Who is widely considered as the first Governor of the Gold Coast?", answerOne: "George McClean", answerTwo: "Sir Charles McCarthy", correctAnswer: "Sir Charles McCarthy"),
        
        EasyModel(question: "Who was the first General Secretary of UGCC?", answerOne: "Kwame Nkrumah", answerTwo: "Ebenezer Ako-Adjei", correctAnswer: "Kwame Nkrumah"),
        
        EasyModel(question: "On what date was the Bond of 1844 signed?", answerOne: "6th March​", answerTwo: "27th August", correctAnswer: "6th March​"),
        
        EasyModel(question: "In which year did construction of the Elmina Castle begin in?", answerOne: "1482", answerTwo: "1471", correctAnswer: "1482"),
        
        EasyModel(question: "Who proposed the name “Ghana”?", answerOne: "JB Danquah​​", answerTwo: "Kwame Nkrumah", correctAnswer: "JB Danquah​​"),
        
        EasyModel(question: "In which year was the Watson Commission formed?", answerOne: "1948", answerTwo: "1946", correctAnswer: "1948"),
        
        EasyModel(question: "Under which regime were three judges and a military officer killed?", answerOne: "Flt. Lt. JJ Rawlings", answerTwo: "Gen IK Acheampong", correctAnswer: "Flt. Lt. JJ Rawlings"),
        
        EasyModel(question: "In which year were Gold Coast ex-servicemen shot during their protest for benefits?", answerOne: "1948", answerTwo: "1949", correctAnswer: "1948"),
        
        EasyModel(question: "Who won the Accra Central seat in the 1951 elections?", answerOne: "Kwame Nkrumah​", answerTwo: "Ebenezer Ako-Adjei", correctAnswer: "Kwame Nkrumah​"),
        
            
    ]
    
    static let medium: [MediumModel] = [
        
        MediumModel(question: "When was Positive Action declared?", answerOne: "January 8, 1950", answerTwo: "January 27,1950", answerThree: "February 3, 1949", answerFour: "February 27, 1949", correctAnswer: "January 8, 1950"),
        
        MediumModel(question: "Who was the President of the 2nd Republic?", answerOne: "KA Busia", answerTwo: "Kwame Nkrumah", answerThree: "Edward Akufo-Addo", answerFour: "FK Apaloo", correctAnswer: "Edward Akufo-Addo"),
        
        MediumModel(question: "Who was the first Ghanaian to be called to the English Bar?", answerOne: "JE Casely-Hayford", answerTwo: "John Mensah Sarbah", answerThree: "Francis Dove", answerFour: "RS Blay", correctAnswer: "John Mensah Sarbah"),
        
        MediumModel(question: "On what date did JJ Rawlings stage his first coup?", answerOne: "15 May 1979", answerTwo: "June 4, 1979", answerThree: "June 3, 1981", answerFour: "December 31, 1981", correctAnswer: "15 May 1979"),
        
        MediumModel(question: "Who was Ghana’s first female MP?", answerOne: "Hannah Cudjoe", answerTwo: "Susan de Graft-Johnson", answerThree: "Annie Jiagge", answerFour: "Mabel Dove", correctAnswer: "Mabel Dove"),
        
        MediumModel(question: "In which year was the Poll Tax Ordinance passed?", answerOne: "1851", answerTwo: "1852", answerThree: "1849", answerFour: "1850", correctAnswer: "1852"),
        
        MediumModel(question: "Who bought the first car in Ghana?", answerOne: "Matthew Nathan", answerTwo: "Lord Passfield", answerThree: "Jacob Sey", answerFour: "George Blankson", correctAnswer: "Matthew Nathan"),
        
        MediumModel(question: "In which year was slavery banished in the Gold Coast?", answerOne: "1867", answerTwo: "1872", answerThree: "1874", answerFour: "1868", correctAnswer: "1874"),
        
        MediumModel(question: "In which year was the University College of Gold Coast founded?", answerOne: "1948", answerTwo: "1944", answerThree: "1952", answerFour: "1947", correctAnswer: "1948"),
        
        MediumModel(question: "Under whose government was the Ministry of Rural Development formed?", answerOne: "Kwame Nkrumah", answerTwo: "Hilla Limann", answerThree: "JJ Rawlings", answerFour: "KA Busia​", correctAnswer: "KA Busia​"),
        
        MediumModel(question: "Who was Ghana’s first female minister?", answerOne: "​Susanna Al-Hassan", answerTwo: "Mabel Dove", answerThree: "Annie Jiagge", answerFour: "Susan de Graft-Johnson", correctAnswer: "​Susanna Al-Hassan"),
        
        MediumModel(question: "In which year did the Yaa Asantewaa War end?", answerOne: "1901", answerTwo: "1900", answerThree: "1888", answerFour: "1899", correctAnswer: "1900"),
        
        MediumModel(question: "Who was the first President of the Committee of Merchants of the Gold Coast?", answerOne: "​George McClean​", answerTwo: "Charles McCarthy", answerThree: "Garnet Wolseley", answerFour: "George Bossman", correctAnswer: "​George McClean​"),
        
        MediumModel(question: "Which regime supervised the switch of Ghana’s mode of driving from left to right?", answerOne: "Afrifa", answerTwo: "Rawlings", answerThree: "Acheampong", answerFour: "Akuffo", correctAnswer: "Acheampong"),
        
        MediumModel(question: "Who led the boycott of European Goods in 1948?", answerOne: "Kwame Nkrumah", answerTwo: "Komla Gbedemah", answerThree: " RS Blay", answerFour: "Nii Kwabena Bonne II​", correctAnswer: "Nii Kwabena Bonne II​"),
        
        MediumModel(question: "Who was the leader of the first Europeans to land on the “Gold Coast”?", answerOne: "​Diego De Azambuja​", answerTwo: "Prince Henry", answerThree: "Adriaan Jacobs", answerFour: "George McClean​", correctAnswer: "​Diego De Azambuja​"),
        
        MediumModel(question: "who among these options was part of the team which translated the Bible into Twi", answerOne: "King Ghartey", answerTwo: "Gaddiel Acquah", answerThree: "David Asante​", answerFour: "Fritz Ramseyer", correctAnswer: "David Asante​"),
        
        MediumModel(question: "Which early political organization laid the foundation for political action against the colonial government?", answerOne: "ARPS", answerTwo: "Togoland Congress", answerThree: "UGCC", answerFour: "CPP", correctAnswer: "ARPS"),
        
        MediumModel(question: "When did the Black Stars win their first AFCON title?", answerOne: "1972", answerTwo: "1978", answerThree: "1963", answerFour: "1980", correctAnswer: "1963"),
        
        MediumModel(question: "When was the Aborigines Rights Protection Society formed?", answerOne: "1867", answerTwo: "1897", answerThree: "1879", answerFour: "1871", correctAnswer: "1897")
        
    ]

    
    static let hard = [
        
        HardModel(question: "Who was the head of the Centre for Civic Education during the NLC regime?", answerOne: "KA Busia", answerTwo: "AA Munufie", answerThree: "Fred Sai", answerFour: "AAY Kyeremateng", correctAnswer: "KA Busia"),
        
        HardModel(question: "On what date did the 1992 Constitution come into full force?", answerOne: "28 April 1992", answerTwo: "7 January 1993", answerThree: "12 June 1993", answerFour: "17 March 1993", correctAnswer: "7 January 1993"),
        
        HardModel(question: "In which year was the Brong-Ahafo region created?", answerOne: " ​1959​", answerTwo: "1963", answerThree: "1958", answerFour: "1961", correctAnswer: "1959​"),
        
        HardModel(question: "Which major coastal town is without a fort?", answerOne: "Anomabo", answerTwo: "Winneba", answerThree: "Cape Coast", answerFour: "Elmina", correctAnswer: "Winneba"),
        
        HardModel(question: "When did Railway Operations begin in the Gold Coast", answerOne: "1901", answerTwo: "1888", answerThree: "1888", answerFour: "1890", correctAnswer: "1901"),
        
        HardModel(question: "Who was the leader of the Togoland Congress?", answerOne: "AK Odame", answerTwo: "F.R. Ametowobla", answerThree: "A. Akakpo", answerFour: "SG Antor​", correctAnswer: "SG Antor​"),
        
        HardModel(question: "Which battle led to the fall of the Denkyira Kingdom?", answerOne: "Battle of Feyiase", answerTwo: "Battle of Bobikuma", answerThree: "Battle of Amoaful", answerFour: "Battle of Ordashu", correctAnswer: "Battle of Feyiase"),
        
        HardModel(question: "In which year did the Denkyira Kingdom fall?", answerOne: "1699", answerTwo: "1703", answerThree: "1701", answerFour: "1702​", correctAnswer: "1701"),
        
        HardModel(question: "Which battle ended the Sagrenti War?", answerOne: "Battle of Ordashu​", answerTwo: "​Battle of Amoaful,", answerThree: "Battle of Bobikuma,", answerFour: "Battle of Feyiase", correctAnswer: "​Battle of Amoaful"),
        
        HardModel(question: "In which year did the first Anglo-Ashanti War start?", answerOne: "1819", answerTwo: "1827", answerThree: "1823", answerFour: "1830", correctAnswer: "1823"),
        
        HardModel(question: "In what year was the first earthquake recorded in Ghana?", answerOne: "1636", answerTwo: "1906", answerThree: "1936", answerFour: "1680", correctAnswer: "1636"),
        
        HardModel(question: "Who presented the first plan of development for the Gold Coast?", answerOne: "Gordon Gugggisburg", answerTwo: "Matthew Nathan", answerThree: "Gerald Creasy", answerFour: "Alan Burns", correctAnswer: "Gordon Gugggisburg"),
        
        HardModel(question: "When did the Dutch capture Elmina Castle from the Portuguese? ", answerOne: "1629", answerTwo: "1635", answerThree: "1637", answerFour: "1639", correctAnswer: "1637"),
        
        HardModel(question: "Who wrote the first history of the Gold Coast?", answerOne: "Carl Reindorf​", answerTwo: "David Asante", answerThree: "Jacobus Capitein,", answerFour: "Kobina Sekyi", correctAnswer: "Carl Reindorf​"),
        
        HardModel(question: "Under whose regime was the One Man One House Committee established?", answerOne: "Acheampong", answerTwo: "Afrifa", answerThree: "Rawlings", answerFour: "Akuffo", correctAnswer: "Rawlings"),
        
        HardModel(question: "Who founded the Accra Evening News?", answerOne: "Mensah Sarbah", answerTwo: "Nnamdi Aziki", answerThree: "Kwame Nkrumah​", answerFour: "RS Blay", correctAnswer: "Kwame Nkrumah​"),
        
        HardModel(question: "In which year were the northern territories added to the jurisdiction of the government of the Gold Coast Colony?", answerOne: "1888", answerTwo: "1894", answerThree: "1901", answerFour: "1902", correctAnswer: "1901"),
        
        HardModel(question: "In which year were the British defeated at the Battle of Bobikuma?", answerOne: "1863​", answerTwo: "1865", answerThree: "1871", answerFour: "1864", correctAnswer: "1863​"),
        
        HardModel(question: "Which Ghanaian was nominated for the Nobel Prize in Physiology or Medicine in 1948?", answerOne: "REG Armattoe​", answerTwo: "Prof. Charles O. Easmon", answerThree: "William Sekyi", answerFour: "CF Grant", correctAnswer: "REG Armattoe​"),
        
        HardModel(question: "Who was the first Gold Coaster to become Governor of Christianborg Castle?", answerOne: "Ntim Gyakar", answerTwo: "King Ghartey", answerThree: "Asameni", answerFour: "Saido Takora", correctAnswer: "Asameni")
    ]

}



