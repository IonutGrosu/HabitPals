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
    
    private init() {}
    
    func dbRef() -> Firestore {
        return Firestore.firestore()
    }
    
    func userDocumentRef(userId: String) -> DocumentReference {
        return dbRef().collection("users/").document(userId)
    }
    
    func createNewUser(user: DbUser) async throws {
        
        try userDocumentRef(userId: user.authId).setData(from: user, merge: false)
    }
    
    
}
