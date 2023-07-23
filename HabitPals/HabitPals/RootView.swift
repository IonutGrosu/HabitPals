//
//  RootView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import SwiftUI
import WidgetKit

struct RootView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationStack {
            MainTabGroupView()
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink {
                            AccountView()
                        } label: {
                            Image(systemName: "person.circle")
                        }
                    }
                }
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .background{
                print("App going to background")
                WidgetCenter.shared.reloadAllTimelines()

            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
