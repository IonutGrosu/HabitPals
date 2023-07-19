//
//  HabitsView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject private var viewModel = HabitsViewModel()
    
    @Binding var isShowingHabitCreateSheet: Bool
    
    @State private var firstOnAppear: Bool = false
    
    var body: some View {
        
        List {
            ForEach($viewModel.habits) {$habit in
                HabitListRow(habit: $habit) {
                    do {
                        try viewModel.updateHabit(habit: habit)
                    } catch {}
                }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                                EdgeInsets(
                                    top: 10,
                                    leading: 10,
                                    bottom: 10,
                                    trailing: 10
                                )
                            ))
            }
        }
        .task {
            do {
                try await viewModel.fetchHabits()
            } catch{}
        }
        .onAppear{
            if !firstOnAppear {
                do {
                    try viewModel.addListenerForHabits()
                    self.firstOnAppear = true
                } catch {}
            }
        }
        .scrollContentBackground(.hidden)
        .overlay(Group {
            if viewModel.habits.isEmpty {
                ZStack {
                    Color("BackgroundColor")
                        .edgesIgnoringSafeArea(.top)
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
        })
        .sheet(isPresented: $isShowingHabitCreateSheet, content: {
            NewHabitSheet(habits: $viewModel.habits, isPresentingSheet: $isShowingHabitCreateSheet){ newHabit in
                do {
                    try viewModel.saveHabit(habit: newHabit)
                } catch{}
            }
        })
        .background{
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.top)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack{
            HabitsView(isShowingHabitCreateSheet: .constant(false))
        }
    }
}
