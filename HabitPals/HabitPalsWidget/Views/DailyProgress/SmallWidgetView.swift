//
//  SmallWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    var entry: HabitsListEntry
    
    @ObservedObject var vm = DailyProgressWidgetViewModel()
    
    var body: some View {
        VStack {
            Text(vm.title)
                .bold()
                .padding(.bottom, 8)
            
            ZStack {
                if vm.totalOngoingHabits == 0 {
                    Text("No ongoing habits to track")
                } else {
                    let progress: Double = vm.habitsCompletedToday/vm.totalOngoingHabits
                    
                    CompletedHabitsProgressCircleView(size: 85, lineWidth: 8, progress: progress)
                    
                    Text("\(Int(vm.habitsCompletedToday))/\(Int(vm.totalOngoingHabits))")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                }
            }.onAppear{
                vm.handleEntry(entry: entry)
            }
        }
    }
}
