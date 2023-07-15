//
//  MainTabGroupView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import SwiftUI

enum SelectedTab {
    case HABITS
    case FRIENDS
}

struct MainTabGroupView: View {
    
    @State private var selectedTab: SelectedTab = .HABITS
    @State private var isShowingHabitCreateSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                switch selectedTab {
                case .HABITS:
                    HabitsView(isShowingHabitCreateSheet: $isShowingHabitCreateSheet)
                        .navigationTitle("Today's Habits")
                case .FRIENDS:
                    FriendsView()
                        .navigationTitle("Friends")
                }
                CustomTabBarView(selectedTab: $selectedTab, isShowingHabitCreateSheet: $isShowingHabitCreateSheet)
                    .frame(height: 42)
            }
        }
    }
}

#Preview {
    MainTabGroupView()
}
