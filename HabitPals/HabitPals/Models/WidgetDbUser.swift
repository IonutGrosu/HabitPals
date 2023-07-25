//
//  WidgetDbUSer.swift
//  HabitPals
//
//  Created by Ionut Grosu on 25/07/2023.
//

import Foundation
import AppIntents

struct WidgetDbUser: Codable {
    
    var id: String
    var name: String
}

extension WidgetDbUser {
    static func getUser(for userName: String) -> WidgetDbUser {
        
        let defaults = UserDefaults(suiteName: "group.com.ionutgrosu.shared")!
        
        if userName == "Myself" {
            let authenticatedUserId = defaults.string(forKey: "authenticatedUserId")!
            return WidgetDbUser(id: authenticatedUserId, name: "Myself")
            
        }
        
        var users: [WidgetDbUser] = []

        if let data = defaults.data(forKey: "widgetFriendsArray") {
            print("Decoding data from user defaults")
            
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                
                // Decode Note
                users = try decoder.decode([WidgetDbUser].self, from: data)
                
            } catch {
                print("Unable to Decode Data (\(error))")
            }
        }
        
        return users.first { user in
            user.name == userName
        }!
    }
}
