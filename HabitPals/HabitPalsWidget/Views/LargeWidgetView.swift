//
//  LargeWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    var entry: SimpleEntry
    
    var body: some View {
        ForEach(entry.habits) { habit in
            HStack{
                Image(systemName: habit.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                Text(habit.name)
                    .font(.title3)
                Spacer()
                Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "checkmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(habit.isCompletedToday ? .green : .gray)
            }.padding()
            Divider()
        }
    }
}
