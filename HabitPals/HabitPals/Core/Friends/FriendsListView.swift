//
//  FriendsView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import SwiftUI

struct FriendsListView: View {
    
    @ObservedObject var vm = FriendsListViewModel()
    
    @State var showingSearchSheet = false
    
    var body: some View {
        List($vm.friends, id: \.self) { $friend in
            FriendHabitsInfoRowView(friend: friend)
        }
        .task {
            await vm.fetchFriends()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {showingSearchSheet = true}, label: {
                    Image(systemName: "plus.circle.fill")
                })
            }
        }
        .sheet(isPresented: $showingSearchSheet, content: {
            NewFriendSearchView(showingSearchSheet: $showingSearchSheet)
        })
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            FriendsListView()
        }
    }
}
