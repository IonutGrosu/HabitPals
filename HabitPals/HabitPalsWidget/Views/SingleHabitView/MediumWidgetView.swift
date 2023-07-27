//
//  MediumWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 27/07/2023.
//

import SwiftUI

struct MediumWidgetView: View {
    let nonCompletedCheckmark: String = "checkmark.circle"
    let completedCheckmark: String = "checkmark.circle.fill"
    
    var entry: SingleHabitEntry
    
    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: entry.habit.icon)
                            .font(.title)
                            .foregroundColor(Color.theme.accent)
                        Text(entry.habit.name)
                            .font(.title2)
                            .foregroundColor(Color.theme.accent)
                        Spacer()
                        
                        Button(intent: CompleteHabitIntent(habitId: entry.habit.id.uuidString)) {
                            Image(systemName: entry.habit.isCompletedToday ? "checkmark.circle.fill" : "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(entry.habit.isCompletedToday ? .green : .gray)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(
                        EdgeInsets(
                            top: 25,
                            leading: 5,
                            bottom: 0,
                            trailing: 5
                        ))
                    
                    if entry.habit.complete {
                        ProgressView(value: entry.habit.completedNumberOfDays, total: entry.habit.totalNumberOfDays, label: {Label("Ongoing for \(entry.habit.completedNumberOfDaysAsInt) days", systemImage: "arrow.triangle.2.circlepath").font(.callout)})
                            .padding(.vertical)
                            .padding(.horizontal, 10)
                            .tint(.green)
                    } else {
                        HStack {
                            ProgressView(value: entry.habit.completedNumberOfDays, total: entry.habit.totalNumberOfDays)
                                .tint(.green)
                            Text("\(entry.habit.completedNumberOfDaysAsInt)/\(entry.habit.totalNumberOfDaysAsInt)")
                                .font(.caption2)
                                .foregroundColor(Color.theme.secondaryText)
                        }
                        .padding()
                    }
                    
                }
    }
}
