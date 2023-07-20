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
    
    func usersCollection() -> CollectionReference {
        return dbRef().collection("users")
    }
    
    func userDocumentRef(_ userId: String) -> DocumentReference {
        return usersCollection().document(userId)
    }
    
    func createNewUser(user: DbUser) async throws {
        
        try userDocumentRef(user.authId).setData(from: user, merge: true)
        
        // TODO - also create document in the friends collection
        FriendsRepository.shared.createEmptyFriendDocument(userId: user.authId)
    }
    
    func getUser(_ userId: String) async -> DbUser {
        var result = DbUser.emptyUser
        do {
            result = try await userDocumentRef(userId).getDocument(as: DbUser.self)
        }catch {}
        return result
    }
    
    func searchUserByNamePrefix(_ namePrefix: String) async -> Query {
        usersCollection()
            .whereField("name", isGreaterThanOrEqualTo: namePrefix)
            .whereField("name", isLessThanOrEqualTo: "\(namePrefix)~")
    }
}
