//
//  FriendsListViewModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 16/07/2023.
//

import Foundation

@MainActor
final class FriendsListViewModel: ObservableObject {
    
    @Published var friends: [DbUser] = []
    
    func fetchFriends() async {
        guard let userId = try? AuthenticationService.shared.getAuthenticatedUserId() else {return}
        
        do {
            friends = try await FriendsRepository.shared.fetchFriends(userId)
        } catch {}
        
        print(friends)
        
    }
    
}
