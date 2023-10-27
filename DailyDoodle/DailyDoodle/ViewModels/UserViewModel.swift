//
//  UserViewModel.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/27/23.
//

import Foundation

class UserViewModel  {
    
    let identifier: String
    let userName: String
    let email: String
    var userDescription: String
    
    var friendIDs: [String]
    var friends: [UserViewModel]?
    
    var drawingIDs: [String]
    var drawings: [Drawing]?
    
    init(identifier: String, userName: String, email: String, userDescription: String, friendIDs: [String], friends: [UserViewModel]?, drawingIDs: [String], drawings: [Drawing]?) {
        self.userName = userName
        self.email = email
        self.userDescription = userDescription
        self.identifier = identifier
        self.friendIDs = friendIDs
        self.friends = friends
        self.drawingIDs = drawingIDs
        self.drawings = drawings
    }
    
    convenience init (json: [String: Any], identifier: String) {
        let username = json[FireBaseConstants.userName] as? String ?? ""
        let email = json[FireBaseConstants.email] as? String ?? ""
        let userDescription = json[FireBaseConstants.userDescription] as? String ?? ""
        let friendIDs = json[FireBaseConstants.friendIDs] as? [String] ?? [String]()
        let drawingIDs = json[FireBaseConstants.drawingIds] as? [String] ?? [String]()
        
        self.init(identifier: identifier,
                  userName: username,
                  email: email,
                  userDescription: userDescription,
                  friendIDs: friendIDs,
                  friends: nil,
                  drawingIDs: drawingIDs,
                  drawings: nil)
    }
}
