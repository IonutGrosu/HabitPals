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
        
        
        // save friends array to user defaults
        
        let widgetFriends: [WidgetDbUser] = friends.map { friend in
            return WidgetDbUser(id: friend.authId, name: friend.name ?? "Unavailable name")
        }
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(widgetFriends)

            // Write/Set Data
            UserDefaults(suiteName: "group.com.ionutgrosu.shared")?.set(data, forKey: "widgetFriendsArray")

        } catch {
            print("Unable to Encode Data (\(error))")
        }
        
    }
    
}
