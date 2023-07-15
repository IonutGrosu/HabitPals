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
        
    func fetchHabits() async {
        let userId = FirebaseAuthService.shared.getAuthenticatedUserId()
        isLoading = true
        self.habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        isLoading = false
    }
    
    func updateHabit(habit: Habit) {
        let userId = FirebaseAuthService.shared.getAuthenticatedUserId()

        try? HabitRepository.shared.saveHabit(userId: userId, habit: habit)
    }
    
    func addListenerForHabits() {
        let userId = FirebaseAuthService.shared.getAuthenticatedUserId()

        HabitRepository.shared.addListenerForHabitsByUserId(userId: userId) { [weak self] habits in
            print("updated habits:\(habits)")
            self?.habits = habits
        }
    }
}
