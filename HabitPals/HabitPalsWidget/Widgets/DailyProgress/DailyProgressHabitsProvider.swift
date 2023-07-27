//
//  Provider.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 24/07/2023.
//

import WidgetKit
import FirebaseCore

struct DailyProgressHabitsProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> HabitsListEntry {
        HabitsListEntry(date: Date(), habits: Habit.sampleData, user: WidgetDbUser(id: "testId", name: "John Doe"), configuration: DailyProgressConfigurationAppIntent())
    }
    
    func snapshot(for configuration: DailyProgressConfigurationAppIntent, in context: Context) async -> HabitsListEntry {
        FirebaseApp.configure() // this seems very stupid, definitely the wrong way to do it

        let user = WidgetDbUser.getUser(for: configuration.user)
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: user.id)
//        let user = await UserRepository.shared.getUser(userId)
        let entry = HabitsListEntry(date: .now, habits: habits, user: user, configuration: configuration)
        return entry
    }
    
    func timeline(for configuration: DailyProgressConfigurationAppIntent, in context: Context) async -> Timeline<HabitsListEntry> {
        FirebaseApp.configure()
        
        let user = WidgetDbUser.getUser(for: configuration.user)
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: user.id)
//        let user = await UserRepository.shared.getUser(userId)
        
        let entry = HabitsListEntry(date: .now, habits: habits,user: user, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .never)
                
        return timeline
    }
}
