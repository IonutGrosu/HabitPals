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
        HabitsEntry(date: Date(), habits: Habit.sampleData, user: WidgetDbUser(id: "testId", name: "John Doe"), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> HabitsEntry {
        FirebaseApp.configure() // this seems very stupid, definitely the wrong way to do it

        let user = WidgetDbUser.getUser(for: configuration.user)
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: user.id)
//        let user = await UserRepository.shared.getUser(userId)
        let entry = HabitsEntry(date: .now, habits: habits, user: user, configuration: configuration)
        return entry
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<HabitsEntry> {
        FirebaseApp.configure()
        
        let user = WidgetDbUser.getUser(for: configuration.user)
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: user.id)
//        let user = await UserRepository.shared.getUser(userId)
        
        let entry = HabitsEntry(date: .now, habits: habits,user: user, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .never)
                
        return timeline
    }
}
