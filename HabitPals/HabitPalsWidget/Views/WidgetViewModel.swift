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
    
    
    func prepareHabits(habits: [Habit]) {
        presentingHabits = Array(habits.prefix(4))
        
        countHabits(habits: habits)
    }
    
    func countHabits(habits: [Habit]) {
        habits.forEach { habit in
            totalOngoingHabits += 1
            
            if habit.isCompletedToday {
                habitsCompletedToday += 1
            }
        }
        
        print("\(Int(habitsCompletedToday))/\(Int(totalOngoingHabits))")
    }
}
