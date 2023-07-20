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
            NavigationLink{
                FriendHabitsListView(friend: friend)
            } label: {
                FriendHabitsInfoRowView(friend: friend)
            }
        }
        .task {
            await vm.fetchFriends()
        }
        .refreshable {
            await vm.fetchFriends()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {showingSearchSheet = true}, label: {
                    Text("Add friends")
                })
            }
        }
        .sheet(isPresented: $showingSearchSheet, content: {
            NewFriendSearchView(showingSearchSheet: $showingSearchSheet)
                .onDisappear(perform: {
                    Task{
                        await vm.fetchFriends()
                    }
                })
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
