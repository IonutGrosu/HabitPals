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
    var saveHabitAction: (_ newHabit: Habit) -> Void
    
    @State private var newHabit: Habit = Habit.emptyHabit
    
    var body: some View {
        NavigationStack {
            HabitEditView(habit: $newHabit)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss"){
                            isPresentingSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Confirm"){
                            saveHabitAction(newHabit)
                            habits.append(newHabit)
                            newHabit = Habit.emptyHabit
                            isPresentingSheet = false
                        }
                    }
                }.tint(.green)
        }
    }
}

struct NewHabitSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewHabitSheet(habits: .constant(Habit.sampleData), isPresentingSheet: .constant(true), saveHabitAction: {newHabit in })
        }
    }
}
