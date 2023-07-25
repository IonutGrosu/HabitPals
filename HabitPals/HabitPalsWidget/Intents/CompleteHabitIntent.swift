//
//  CompleteHabitIntent.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 23/07/2023.
//

import Foundation
import AppIntents

struct CompleteHabitIntent: AppIntent {
    static var title: LocalizedStringResource = "Complete Habit"
    
    @Parameter(title: "HabitId")
    var habitId: String
    
    init() {
        self.habitId = ""
    }
    
    init(habitId: String) {
        self.habitId = habitId
    }
    
    func perform() async throws -> some IntentResult {
        
        print("habit with id \(habitId) completed today from widget")
        
        let userId = "aKDrkWarl2UfI7vjfTrOOMhWAul1"
        
        var habit = await HabitRepository.shared.fetchHabitWithId(habitId: habitId, userId: userId)
        habit.completeToday()
        try HabitRepository.shared.saveHabit(habit: habit, userId: userId)
        
        return .result()
    }
    
}
