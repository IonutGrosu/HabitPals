//
//  SingleHabitConfigurationAppIntent.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 27/07/2023.
//

import WidgetKit
import AppIntents

struct SingleHabitConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Habit"
    
    @Parameter(title: "Habit", optionsProvider: HabitOptionsProvider())
    var habit: String
    
    struct HabitOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            var habits: [Habit] = []
            
            let defaults = UserDefaults(suiteName: "group.com.ionutgrosu.shared")!
            
            if let data = defaults.data(forKey: "widgetHabitsArray") {
                print("Decoding data from user defaults")
                
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()
                    
                    // Decode Note
                    habits = try decoder.decode([Habit].self, from: data)
                    
                } catch {
                    print("Unable to Decode Data (\(error))")
                }
            }
            let habitTitles: [String] = habits.map { habit in
                habit.name
            }
            
            return habitTitles
        }
    }
}
