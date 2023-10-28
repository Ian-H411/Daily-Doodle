//
//  UserNetworkManager.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/27/23.
//

import FirebaseFirestore
import FirebaseAuth

struct FireBaseConstants {
    static let usersCollectionPath = "users"
    
    static let userName = "userName"
    static let email = "email"
    static let drawingIds = "drawingIDs"
    static let friendIDs = "friendIDs"
    static let userDescription = "userDescription"
}

class UserNetworkManager {
    
    static let shared = UserNetworkManager()
    
    private let db = Firestore.firestore()
    
    func createUser(user: UserViewModel) {
        let usersCollection = db.collection(FireBaseConstants.usersCollectionPath)
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userDocument = usersCollection.document(userID)
        
        let userData: [String: Any] = [
            FireBaseConstants.userName: user.userName,
            FireBaseConstants.email: user.email,
            FireBaseConstants.drawingIds: user.drawingIDs,
            FireBaseConstants.friendIDs: user.friendIDs,
            FireBaseConstants.userDescription: user.userDescription
        ]
        
        userDocument.setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully!")
            }
        }
    }
    
    func getUserFrom(id: String, completionHandler: @escaping (UserViewModel?) -> Void) {
        let userCollection = db.collection(FireBaseConstants.usersCollectionPath)
        let userDocument = userCollection.document(id)
        
        userDocument.getDocument { document, error in
            if let error = error {
                print("\(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            if let document = document,
               document.exists,
               let data = document.data() {
                let user = UserViewModel(json: data, identifier: id)
                completionHandler(user)
                return
            } else {
                print("Unable to parse document for user retrieval by ID")
                completionHandler(nil)
                return
            }
        }
    }
    
    func retrieveFriendsWith(IDs: [String], completionHandler: @escaping ([UserViewModel]?) -> Void) {
        let usersCollection = db.collection(FireBaseConstants.usersCollectionPath)
        
        usersCollection.whereField(FieldPath.documentID(), in: IDs).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting user data: \(error.localizedDescription)")
                completionHandler(nil)
                return
            } else {
                var retrievedUsers: [UserViewModel] = []
                guard let documents = querySnapshot?.documents else { completionHandler(nil); return }
                for document in documents{
                    let data = document.data() 
                    retrievedUsers.append(UserViewModel(json: data, identifier: document.documentID))
                }
                completionHandler(retrievedUsers)
                return
            }
        }
    }
}
