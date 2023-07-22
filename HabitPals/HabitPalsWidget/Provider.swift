//
//  Provider.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), habits: Habit.sampleData )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
//                let userId = try AuthenticationService.shared.getAuthenticatedUserId()
                let userId = "aKDrkWarl2UfI7vjfTrOOMhWAul1"
                let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
//                let firstFourHabits = Array(habits.prefix(4))
                let entry = SimpleEntry(date: .now, habits: habits)
                completion(entry)
            } catch {
                print("widget issues, substituting sample habit")
                completion(SimpleEntry(date: .now, habits: [Habit.sampleData[0]]))
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task {
            do {
//                let userId = try AuthenticationService.shared.getAuthenticatedUserId()
                let userId = "aKDrkWarl2UfI7vjfTrOOMhWAul1"
                let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
//                let firstFourHabits = Array(habits.prefix(4))
                
                let entry = SimpleEntry(date: .now, habits: habits)
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 30)))
                
                completion(timeline)
            } catch {
                let entry = SimpleEntry(date: .now, habits: Habit.sampleData)
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 30)))
                
                completion(timeline)
            }
        }
    }
}
