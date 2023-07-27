//
//  HabitsViewModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 13/07/2023.
//

import Foundation
import FirebaseFirestore

@MainActor
final class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var isLoading: Bool = true
        
    func fetchHabits() async throws {
        let userId = try AuthenticationService.shared.getAuthenticatedUserId()
        isLoading = true
        self.habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        isLoading = false
        
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(habits)

            // Write/Set Data
            UserDefaults(suiteName: "group.com.ionutgrosu.shared")?.set(data, forKey: "widgetHabitsArray")
            print("Saved habits to defaults")

        } catch {
            print("Unable to Encode Data (\(error))")
        }
    }
    
    func saveHabit(habit: Habit) throws {
        let userId = try AuthenticationService.shared.getAuthenticatedUserId()

        try HabitRepository.shared.saveHabit(habit: habit, userId: userId)
    }
    
    func updateHabit(habit: Habit) throws {
        let userId = try AuthenticationService.shared.getAuthenticatedUserId()

        try? HabitRepository.shared.saveHabit(habit: habit, userId: userId)
    }
    
    func addListenerForHabits() throws {
        let userId = try AuthenticationService.shared.getAuthenticatedUserId()

        HabitRepository.shared.addListenerForHabitsByUserId(userId: userId) { [weak self] habits in
            self?.habits = habits
        }
    }
}
