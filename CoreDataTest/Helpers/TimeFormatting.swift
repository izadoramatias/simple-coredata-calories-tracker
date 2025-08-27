//
//  TimeFormatting.swift
//  CoreDataTest
//
//  Created by Izadora Matias on 27/08/25.
//
import Foundation

struct TimeFormatting {
    static func calcTimeSince(date: Date) -> String {
        let minutes = Int(-date.timeIntervalSinceNow) / 60
        let hours = minutes / 60
        let days = hours / 24
       
        if minutes < 60 {
            return "\(minutes) minutes ago"
        }
        
        if minutes >= 60 && hours < 24 {
            return "\(hours) hours ago"
        }
        
        return "\(days) days ago"
        
    }
}
