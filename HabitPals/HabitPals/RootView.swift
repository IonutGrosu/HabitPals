//
//  RootView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import SwiftUI



struct RootView: View {
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
                        .tint(.black)
                    }
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
