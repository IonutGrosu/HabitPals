//
//  SmallWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    var entry: SimpleEntry
    
    @State var totalOngoingHabits = 0.0
    @State var habitsCompletedToday = 0.0
    
    var body: some View {
        ZStack {
            HabitsCompletionStatusArc(totalOngoingHabits: $totalOngoingHabits, habitsCompletedToday: $habitsCompletedToday, size: 120, lineWidth: 8)
            Text("\(Int(habitsCompletedToday))/\(Int(totalOngoingHabits))")
                .font(.system(size: 48, weight: .bold))
        }.onAppear{
            countHabits(habits: entry.habits)
        }
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
