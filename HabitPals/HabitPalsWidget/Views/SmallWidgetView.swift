//
//  SmallWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    var entry: HabitsEntry
    
    @ObservedObject var vm = WidgetViewModel()
    
    var body: some View {
        ZStack {
            if vm.totalOngoingHabits == 0 {
                Text("No ongoing habits to track")
            } else {
                let progress: Double = vm.habitsCompletedToday/vm.totalOngoingHabits
                
                CompletedHabitsProgressCircleView(size: 125, lineWidth: 15, progress: progress)
                
                Text("\(Int(vm.habitsCompletedToday))/\(Int(vm.totalOngoingHabits))")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
            }
        }.onAppear{
            vm.prepareHabits(habits: entry.habits)
        }
    }
}
