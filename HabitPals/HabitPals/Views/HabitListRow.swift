//
//  HabitListRow.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import SwiftUI

struct HabitListRow: View {
    let nonCompletedCheckmark: String = "checkmark.circle"
    let completedCheckmark: String = "checkmark.circle.fill"
    
    @Binding var habit: Habit
    
    @State var showConfetti: Bool = false
    
    var habitUpdateAction: (_ showConfetti: Bool) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: habit.icon)
                    .font(.title)
                    .foregroundColor(Color.theme.accent)
                Text(habit.name)
                    .font(.title2)
                    .foregroundColor(Color.theme.accent)
                Spacer()
                Button {
                    if habit.isCompletedToday == false { 
                        habit.completeToday()
                        habitUpdateAction(showConfetti)
                    }
                } label: {
                    Image(systemName: habit.isCompletedToday==true ? completedCheckmark : nonCompletedCheckmark)
                        .font(.title)
                        .tint(.green)
                }
                
            }
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 5,
                    bottom: 0,
                    trailing: 5
                ))
            HStack {
                ProgressView(value: habit.completedNumberOfDays, total: habit.totalNumberOfDays)
                    .tint(.green)
                Text("\(habit.completedNumberOfDaysAsInt)/\(habit.totalNumberOfDaysAsInt)")
                    .font(.caption2)
                    .foregroundColor(Color.theme.secondaryText)
            }
            .padding()
        }
        .onChange(of: habit.complete) { _ in
            showConfetti = true
        }
    }
}

struct HabitListRow_Previews: PreviewProvider {
    static var previews: some View {
        HabitListRow(habit: .constant(Habit.sampleData[0]), habitUpdateAction: {showConfetti in })
    }
}
