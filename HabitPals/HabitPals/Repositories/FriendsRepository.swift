//
//  FriendsRepository.swift
//  HabitPals
//
//  Created by Ionut Grosu on 16/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FriendsRepository {
    static let shared = FriendsRepository()
    
    private init(){}
    
    func dbRef() -> Firestore {
        return Firestore.firestore()
    }
    
    func friendsCollection() -> CollectionReference {
        return dbRef().collection("friends")
    }
    
    func userDocumentRef(_ userId: String) -> DocumentReference {
        return friendsCollection().document(userId)
    }
    
    func fetchFriends(_ userId: String) async throws -> [DbUser] {
        
        var friends: [DbUser] = []
        
        let friendsIds = await fetchFriendsIds(userId)
        
        friends = await friendsIds.asyncMap({ id in
            await UserRepository.shared.getUser(id)
        })
                
        return friends
    }
    
    func fetchFriendsIds(_ userId: String) async -> [String] {
        
        var result: [String] = []
        
        do {
            result = try await userDocumentRef(userId).getDocument(as: DbFriendList.self).ids
        } catch {}
        
        return result
    }
    
    func createEmptyFriendDocument(userId: String) {
        userDocumentRef(userId).setData([:])
    }
    
    func addFriend(friendId: String) {
        guard let currentUserId = try? AuthenticationService.shared.getAuthenticatedUserId() else {return}

        // add to current user's friends list
        userDocumentRef(currentUserId).updateData([
            "ids": FieldValue.arrayUnion([friendId])
        ])
        
        // add current user to the friend's list of friends
        userDocumentRef(friendId).updateData([
            "ids": FieldValue.arrayUnion([currentUserId])
        ])
    }
    
    func removeFriend(friendId: String) {
        guard let currentUserId = try? AuthenticationService.shared.getAuthenticatedUserId() else {return}
        
        // remove from current user's friends list
        userDocumentRef(currentUserId).updateData([
            "ids": FieldValue.arrayRemove([friendId])
        ])
        
        // remove current user from the friend's list of friends
        userDocumentRef(friendId).updateData([
            "ids": FieldValue.arrayRemove([currentUserId])
        ])
    }
}
