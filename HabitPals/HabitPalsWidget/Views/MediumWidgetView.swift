//
//  MediumWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI

struct MediumWidgetView: View {
    var entry: HabitsEntry
    
    var habit: Habit = Habit.sampleData[0]
    let nonCompletedCheckmark: String = "checkmark.circle"
    let completedCheckmark: String = "checkmark.circle.fill"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: habit.icon)
                    .font(.title)
                    .foregroundColor(Color.theme.accent)
                Text(habit.name)
                    .font(.title2)
                    .foregroundColor(Color.theme.accent)
                Spacer()
                Image(systemName: habit.isCompletedToday==true ? completedCheckmark : nonCompletedCheckmark)
                    .font(.title)
                    .tint(.green)
            }
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 5,
                    bottom: 0,
                    trailing: 5
                ))
            
            if habit.complete {
                ProgressView(value: habit.completedNumberOfDays, total: habit.totalNumberOfDays, label: {Label("Ongoing for \(habit.completedNumberOfDaysAsInt) days", systemImage: "arrow.triangle.2.circlepath").font(.callout)})
                    .padding(.vertical)
                    .padding(.horizontal, 10)
                    .tint(.green)
            } else {
                HStack {
                    ProgressView(value: habit.completedNumberOfDays, total: habit.totalNumberOfDays)
                        .tint(.green)
                    Text("\(habit.completedNumberOfDaysAsInt)/\(habit.totalNumberOfDaysAsInt)")
                        .font(.caption2)
                        .foregroundColor(Color.theme.secondaryText)
                }
                .padding()
            }
            
        }
    }
}
