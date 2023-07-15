//
//  UserRepository.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation
import FirebaseFirestore

struct UserRepository {
    
    static let shared = UserRepository()
    
    private init() {
        
    }
    
    func dbRef() -> Firestore {
        return Firestore.firestore()
    }
    
    func userDocumentRef(userId: String) -> DocumentReference {
        return dbRef().collection("users/").document(userId)
    }
    
    func saveAccount(user: User) {        
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.setValue(data, forKey: "loggedInUser")
        } catch {
            return
        }
                
        userDocumentRef(userId: user.authId).setData(user.dictionary)
    }
    
    
}
