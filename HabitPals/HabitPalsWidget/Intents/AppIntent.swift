//
//  AppIntent.swift
//  HabitPalsWidget
//
//  Created by Ionut Grosu on 24/07/2023.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select User"

    // An example configurable parameter.
    @Parameter(title: "User", optionsProvider: UsersOptionsProvider())
    var user: String
    
    struct UsersOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            var friends: [WidgetDbUser] = []
            
            let defaults = UserDefaults(suiteName: "group.com.ionutgrosu.shared")!
                        
            if let data = defaults.data(forKey: "widgetFriendsArray") {
                print("Decoding data from user defaults")
                
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()
                    
                    
                    // Decode Note
                    friends = try decoder.decode([WidgetDbUser].self, from: data)
                    
                } catch {
                    print("Unable to Decode Data (\(error))")
                }
            }
                        
            var friendNames: [String] = friends.map { friend in
                friend.name
            }
            
            friendNames.append("Myself")
            
            return friendNames
        }
    }
    
    
}
