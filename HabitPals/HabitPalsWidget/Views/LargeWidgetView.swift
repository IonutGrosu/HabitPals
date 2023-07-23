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
    
    @ObservedObject var vm = WidgetViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Text("\(Int(vm.habitsCompletedToday))/\(Int(vm.totalOngoingHabits))")
                    .font(.system(.title, design: .rounded))
                    .bold()
                
                Spacer()
                
                CompletedHabitsProgressCircleView()
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
                    Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(habit.isCompletedToday ? .green : .gray)
                }.padding()
                Divider()
            }
            
            Spacer()
            
        }.onAppear{
            vm.prepareHabits(habits: entry.habits)
        }
    }
    

}
