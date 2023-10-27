//
//  UserViewModel.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/27/23.
//

import Foundation

class UserViewModel  {
    
    var identifier: String
    
    var friendIDs: [String]
    var friends: [UserViewModel]
    
    var drawingIDs: [String]
    var drawings: [Drawing]
    
    init(identifier: String, friendIDs: [String], friends: [UserViewModel], drawingIDs: [String], drawings: [Drawing]) {
        self.identifier = identifier
        self.friendIDs = friendIDs
        self.friends = friends
        self.drawingIDs = drawingIDs
        self.drawings = drawings
    }
}
