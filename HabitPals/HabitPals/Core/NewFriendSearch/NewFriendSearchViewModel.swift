//
//  NewFriendSearchViewModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 18/07/2023.
//

import Foundation

@MainActor
final class NewFriendSearchViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    
    @Published var userSearchResults: [DbUser] = []
    
    func search() async {
        if searchTerm.isEmpty {
            userSearchResults = []
            return
        }
        
        do {
            let querySnapshot = try await UserRepository.shared.searchUserByNamePrefix(searchTerm).getDocuments()
            
            userSearchResults = querySnapshot.documents.compactMap({try? $0.data(as: DbUser.self)})
            
        } catch {}
        
        await removeFriendsFromResult()
        
        removeCurrentUserFromResult()
    }
    
    private func removeCurrentUserFromResult() {
        guard let currentUserId = try? AuthenticationService.shared.getAuthenticatedUserId() else {return}
        
        userSearchResults.removeAll { user in
            user.authId == currentUserId
        }
    }
    
    private func removeFriendsFromResult() async {
        guard let currentUserId = try? AuthenticationService.shared.getAuthenticatedUserId() else {return}

        let friendIds = await FriendsRepository.shared.fetchFriendsIds(currentUserId)

        userSearchResults.removeAll { user in
            friendIds.contains(user.authId)
        }
    }
    
    func addFriend(friendId: String) {
        FriendsRepository.shared.addFriend(friendId: friendId)
    }
}
