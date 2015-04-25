//
//  Video.swift
//  WWDC
//
//  Created by Guilherme Rambo on 18/04/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import Foundation

let SessionProgressDidChangeNotification = "SessionProgressDidChangeNotification"

struct Session {
    
    var date: String?
    var description: String
    var focus: [String]
    var id: Int
    var slides: String?
    var title: String
    var track: String
    var url: String
    var year: Int
    var hd_url: String?
    var isSpecialEvent = false
    
    private var settedSubtitle: String?
    var subtitle: String {
        get {
            if let subtitle = settedSubtitle {
                return subtitle
            } else {
                return "\(year) - Session \(id)"
            }
        }
    }
    mutating func setSubtitle(subtitle: String?) {
        settedSubtitle = subtitle
    }
    mutating func setSpecialEvent(special: Bool) {
        isSpecialEvent = special
    }
    
    var progress: Double {
        get {
            return DataStore.SharedStore.fetchSessionProgress(self)
        }
        set {
            DataStore.SharedStore.putSessionProgress(self, progress: newValue)
            NSNotificationCenter.defaultCenter().postNotificationName(SessionProgressDidChangeNotification, object: self.progressKey)
        }
    }
    
    var currentPosition: Double {
        get {
            return DataStore.SharedStore.fetchSessionCurrentPosition(self)
        }
        set {
            DataStore.SharedStore.putSessionCurrentPosition(self, position: newValue)
        }
    }
    
    var progressKey: String {
        get {
            if isSpecialEvent {
                return "\(title)-\(subtitle)-progress"
            } else {
                return "\(year)-\(id)-progress"
            }
        }
    }
    var currentPositionKey: String {
        get {
            if isSpecialEvent {
                return "\(title)-\(subtitle)-currentPosition"
            } else {
                return "\(year)-\(id)-currentPosition"
            }
        }
    }
    
    init(date: String?, description: String, focus: [String], id: Int, slides: String?, title: String, track: String, url: String, year: Int, hd_url: String?)
    {
        self.date = date
        self.description = description
        self.focus = focus
        self.id = id
        self.slides = slides
        self.title = title
        self.track = track
        self.url = url
        self.year = year
        self.hd_url = hd_url
    }
    
}