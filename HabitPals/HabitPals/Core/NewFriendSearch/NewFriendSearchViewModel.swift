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
    }
    
    func addFriend(friendId: String) {
        FriendsRepository.shared.addFriend(friendId: friendId)
    }
}
