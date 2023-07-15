//
//  CustomTabBarView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 09/07/2023.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: SelectedTab
    @Binding var isShowingHabitCreateSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                selectedTab = .HABITS
            } label: {
                VStack {
                    Image(systemName: "checklist")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .bold()
                    Text("Habits")
                        .font(.caption)
                }
                .foregroundColor(selectedTab == .HABITS ? .green : .black)
                
            }
            Spacer()
            Button {
                isShowingHabitCreateSheet = true
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 2)
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .foregroundColor(.green)
                }
                .offset(y:-32)
            }
            Spacer()
            Button {
                selectedTab = .FRIENDS
            } label: {
                VStack {
                    Image(systemName: "person.2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .bold()
                    Text("Friends")
                        .font(.caption)
                }
                .foregroundColor(selectedTab == .FRIENDS ? .green : .black)
            }
            Spacer()
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(selectedTab: .constant(.HABITS), isShowingHabitCreateSheet: .constant(false))
    }
}
