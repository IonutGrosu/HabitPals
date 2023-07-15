//
//  HabitEditView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 08/07/2023.
//

import SwiftUI

struct HabitEditView: View {
    
    @Binding var habit: Habit
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Details") {
                    TextField("Name", text: $habit.name)
                    VStack(alignment: .leading) {
                        Text("Repeating for \(habit.totalNumberOfDaysAsInt) days")
                        Slider(value: $habit.totalNumberOfDays, in: 20...60, step: 1)
                    }
                    SymbolPicker(selection: $habit.icon)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.ultraThinMaterial)
        }
    }
}

struct HabitEditView_Previews: PreviewProvider {
    static var previews: some View {
        HabitEditView(habit: .constant(Habit.sampleData[1]))
    }
}
