//
//  LargeWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    var entry: HabitsEntry
    
    @ObservedObject var vm = WidgetViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            if vm.totalOngoingHabits == 0 {
                Text("No ongoing habits to track")
            } else {
                
                HStack {
                    Text("My progress")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    Text("\(Int(vm.habitsCompletedToday))/\(Int(vm.totalOngoingHabits))")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    CompletedHabitsProgressCircleView(progress: vm.habitsCompletedToday/vm.totalOngoingHabits)
                }
                .padding(.top, 24)
                .padding(.horizontal)
                
                ForEach(vm.presentingHabits) { habit in
                    HStack{
                        Image(systemName: habit.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        Text(habit.name)
                            .font(.title3)
                        Spacer()
                        
                        Button(intent: CompleteHabitIntent(habitId: habit.id.uuidString)) {
                            Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(habit.isCompletedToday ? .green : .gray)
                        }
                        .buttonStyle(.plain)
                        .disabled(habit.isCompletedToday)
                        
                    }.padding()
                    Divider()
                }
                Spacer()
            }
        }.onAppear{
            vm.prepareHabits(habits: entry.habits)
        }
    }
    

}
