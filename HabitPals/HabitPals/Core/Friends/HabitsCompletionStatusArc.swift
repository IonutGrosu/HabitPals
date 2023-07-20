//
//  HabitsCompletionStatusArc.swift
//  HabitPals
//
//  Created by Ionut Grosu on 19/07/2023.
//

import SwiftUI

struct HabitsCompletionStatusArc: View {
    
    @State var totalOngoingHabits: Double
    @State var habitsCompletedToday: Double
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
        if totalOngoingHabits == 0 {
            return 0
        } else {
            return 360.0 * (habitsCompletedToday / totalOngoingHabits)
        }
    }
}

#Preview {
    HabitsCompletionStatusArc(totalOngoingHabits: 2, habitsCompletedToday: 2)
}
