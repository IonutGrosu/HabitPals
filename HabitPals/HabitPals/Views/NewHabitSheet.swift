//
//  NewHabitSheet.swift
//  HabitPals
//
//  Created by Ionut Grosu on 08/07/2023.
//

import SwiftUI

struct NewHabitSheet: View {
    @Binding var habits: [Habit]
    @Binding var isPresentingSheet: Bool
    var saveHabitAction: () -> Void
    
    @State private var newHabit: Habit = Habit.emptyHabit
    
    var body: some View {
        NavigationStack {
            HabitEditView(habit: $newHabit)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss"){
                            // save the newly created habit
                            isPresentingSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Confirm"){
                            // save the newly created habit
                            try? HabitRepository.shared.saveHabit(habit: newHabit)
                            habits.append(newHabit)
                            newHabit = Habit.emptyHabit
                            isPresentingSheet = false
                            saveHabitAction()
                        }
                    }
                }.tint(.green)
        }
    }
}

struct NewHabitSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewHabitSheet(habits: .constant(Habit.sampleData), isPresentingSheet: .constant(true), saveHabitAction: {})
        }
    }
}
