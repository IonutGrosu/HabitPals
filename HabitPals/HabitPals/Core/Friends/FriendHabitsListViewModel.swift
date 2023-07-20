//
//  FriendHabitsListViewModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 19/07/2023.
//

import Foundation

@MainActor
final class FriendHabitsListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    func fetchHabits(userId: String) async {
        habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
    }
}
