//
//  SingleHabitViewProvider.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 27/07/2023.
//

import WidgetKit

struct SingleHabitViewProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SingleHabitEntry {
        SingleHabitEntry(date: Date(), habit: Habit.sampleData[0], configuration: SingleHabitConfigurationAppIntent())
    }
    
    func snapshot(for configuration: SingleHabitConfigurationAppIntent, in context: Context) async -> SingleHabitEntry {
        let entry = SingleHabitEntry(date: .now, habit: fetchConfiguredHabit(configuration.habit), configuration: SingleHabitConfigurationAppIntent())
        return entry
    }
    
    func timeline(for configuration: SingleHabitConfigurationAppIntent, in context: Context) async -> Timeline<SingleHabitEntry> {
        let entry = SingleHabitEntry(date: .now, habit: fetchConfiguredHabit(configuration.habit), configuration: SingleHabitConfigurationAppIntent())
        let timeline = Timeline(entries: [entry], policy: .never)
                
        return timeline
    }
    
    private func fetchConfiguredHabit(_ habitName: String) -> Habit {
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
        
        let habit = habits.first { habit in
            habit.name == habitName
        }
        
        return habit!
    }
    
}
