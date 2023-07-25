//
//  Provider.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 24/07/2023.
//

import WidgetKit
import FirebaseCore

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> HabitsEntry {
        HabitsEntry(date: Date(), habits: Habit.sampleData, configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> HabitsEntry {
        FirebaseApp.configure() // this seems very stupid, definitely the wrong way to do it
        let userId = UserDefaults(suiteName: "group.com.ionutgrosu.shared")?.string(forKey: "authenticatedUserId") ?? ""
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        
        let entry = HabitsEntry(date: .now, habits: habits, configuration: configuration)
        return entry
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<HabitsEntry> {
        
        FirebaseApp.configure()
        let userId = UserDefaults(suiteName: "group.com.ionutgrosu.shared")?.string(forKey: "authenticatedUserId") ?? ""
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        
        let entry = HabitsEntry(date: .now, habits: habits, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 1)))
                
        return timeline
    }
}
