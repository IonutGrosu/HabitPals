//
//  SingleHabitViewProvider.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 27/07/2023.
//

import WidgetKit
import FirebaseCore

struct SingleHabitViewProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SingleHabitEntry {
        SingleHabitEntry(date: Date(), habit: Habit.sampleData[0], configuration: SingleHabitConfigurationAppIntent())
    }
    
    func snapshot(for configuration: SingleHabitConfigurationAppIntent, in context: Context) async -> SingleHabitEntry {
        let entry = SingleHabitEntry(date: .now, habit:  await fetchConfiguredHabit(configuration.habit), configuration: SingleHabitConfigurationAppIntent())
        return entry
    }
    
    func timeline(for configuration: SingleHabitConfigurationAppIntent, in context: Context) async -> Timeline<SingleHabitEntry> {
        let entry = SingleHabitEntry(date: .now, habit: await fetchConfiguredHabit(configuration.habit), configuration: SingleHabitConfigurationAppIntent())
        let timeline = Timeline(entries: [entry], policy: .never)
                
        return timeline
    }
    
    private func fetchCurrentUserId() -> String {
        let defaults = UserDefaults(suiteName: "group.com.ionutgrosu.shared")!
        
        return defaults.string(forKey: "authenticatedUserId")!
    }
    
    private func fetchConfiguredHabit(_ habitName: String) async -> Habit {
        FirebaseApp.configure() // this seems very stupid, definitely the wrong way to do it
        
        let userId = fetchCurrentUserId()
        
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        
        let chosenHabit = habits.first { h in
            h.name == habitName
        }
        
        return chosenHabit ?? Habit.emptyHabit
    }
    
}
