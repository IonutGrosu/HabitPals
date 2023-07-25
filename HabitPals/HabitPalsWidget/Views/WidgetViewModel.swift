//
//  WidgetViewModel.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 23/07/2023.
//

import Foundation

final class WidgetViewModel: ObservableObject {
    @Published var presentingHabits: [Habit] = []
    @Published var totalOngoingHabits = 0.0
    @Published var habitsCompletedToday = 0.0
    @Published var title = ""
    
    func handleEntry(entry: HabitsEntry) {
        setTitle(userName: entry.user.name)
        prepareHabits(habits: entry.habits)
        countHabits(habits: entry.habits)
    }
    
    func setTitle(userName: String) {
        title = userName == "Myself" ? "My progress" : userName
    }
    
    func prepareHabits(habits: [Habit]) {
        presentingHabits = Array(habits.prefix(4))
    }
    
    func countHabits(habits: [Habit]) {
        habits.forEach { habit in
            totalOngoingHabits += 1
            
            if habit.isCompletedToday {
                habitsCompletedToday += 1
            }
        }
    }
}
