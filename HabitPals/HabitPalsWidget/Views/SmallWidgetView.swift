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
    
    var body: some View {
        ZStack {
            HabitsCompletionStatusArc(totalOngoingHabits: .constant(4), habitsCompletedToday: .constant(3), size: 120, lineWidth: 8)
            Text("3/4")
                .font(.system(size: 48, weight: .bold))
        }
    }
}
