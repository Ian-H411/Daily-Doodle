//
//  UserNetworkManager.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/27/23.
//

import FirebaseFirestore
import FirebaseAuth

class UserNetworkManager {
    
    static let shared = UserNetworkManager()
    
    func createUser(user: UserViewModel) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userDocument = usersCollection.document(userID)
        
        let userData: [String: Any] = [
            "username": user.userName,
            "email": user.email,
            "drwaingIDs": user.drawingIDs,
            "friends": user.friendIDs,
            "userDescription": user.userDescription
        ]
        
        userDocument.setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully!")
            }
        }
    }
}
