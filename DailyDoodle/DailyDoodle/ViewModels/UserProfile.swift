//
//  UserProfile.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/25/23.
//

import SwiftUI

class UserProfile {
     
    var friendIDs: [String]
    var friends: [UserProfile]
    
    var drawingIDs: [String]
    var drawings: [Drawing]
    
    var profilePicture: Image?
    
    var description: String
    
    init(friends: [UserProfile], friendIDs: [String], drawings: [Drawing], drawingIDs: [String], profilePicture: Image?, description: String) {
        self.friends = friends
        self.friendIDs = friendIDs
        self.drawingIDs = drawingIDs
        self.drawings = drawings
        self.profilePicture = profilePicture
        self.description = description
    }
    
    convenience init(json: [String: Any]) {
        //TODO: -- uwrap json here then use base initializer
        self.init(friends: [UserProfile](), friendIDs: [String](), drawings: [Drawing](), drawingIDs: [String](), profilePicture: nil, description: "")
    }
}
