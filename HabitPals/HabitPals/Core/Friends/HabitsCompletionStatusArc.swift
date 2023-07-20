//
//  HabitsCompletionStatusArc.swift
//  HabitPals
//
//  Created by Ionut Grosu on 19/07/2023.
//

import SwiftUI

struct HabitsCompletionStatusArc: View {
    
    @Binding var totalOngoingHabits: Double
    @Binding var habitsCompletedToday: Double
    var uncompletedHabits: Double {
        totalOngoingHabits-habitsCompletedToday
    }
    
    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(getEndAngle()), clockwise: false)
            .stroke(uncompletedHabits == 0 ? .green : .yellow, lineWidth: 4)
            .frame(width: 60, height: 60)
            .rotationEffect(.degrees(-90))
    }
    
    func getEndAngle() -> Double {
        print(totalOngoingHabits)

        if totalOngoingHabits == 0.0 {
            return 0.0
        } else {
            return 360.0 * (habitsCompletedToday / totalOngoingHabits)
        }
    }
}

#Preview {
    HabitsCompletionStatusArc(totalOngoingHabits: .constant(2), habitsCompletedToday: .constant(2))
}
