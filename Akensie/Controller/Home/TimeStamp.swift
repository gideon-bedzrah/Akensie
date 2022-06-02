//
//  TimeStamp.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 20/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit

extension Date {
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minutes = 60
        let hour = minutes * 60
        let day = 24 * hour
        let week = day * 7
        let month = week * 4
        let year = month * 12
        
        if secondsAgo < minutes {
            return "\(secondsAgo) seconds ago"
        }else if secondsAgo < hour {
            if secondsAgo/minutes == 1 {
                return "\(secondsAgo/minutes) min ago"
            }else{
            return "\(secondsAgo/minutes) mins ago"
            }
        }else if secondsAgo < day {
            if secondsAgo/hour == 1 {
                return "\(secondsAgo/hour) hour ago"
            }else {
                return "\(secondsAgo/hour) hours ago"
            }
        }else if secondsAgo < week {
            if secondsAgo/day == 1 {
                return "\(secondsAgo/day) day ago"
            }else{
                return "\(secondsAgo/day) days ago"
            }
        }else if secondsAgo < month {
            if secondsAgo/week == 1 {
                return "\(secondsAgo/week) week ago"
            }else{
                return "\(secondsAgo/week) weeks ago"
            }
        }else {
            if secondsAgo/month == 1 {
                return "\(secondsAgo/month) month ago"
            }else{
            return "\(secondsAgo/month) months ago"
            }
        }
    }
}
