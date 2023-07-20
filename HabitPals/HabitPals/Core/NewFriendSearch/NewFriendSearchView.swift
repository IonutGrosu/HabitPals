//
//  NewFriendSearchView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 18/07/2023.
//

import SwiftUI

struct NewFriendSearchView: View {
    
    @ObservedObject var viewModel = NewFriendSearchViewModel()
    
    @Binding var showingSearchSheet: Bool
    
    var body: some View {
        VStack{
            TextField("User name..", text: $viewModel.searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            List($viewModel.userSearchResults, id: \.self) { $user in
                UserSearchInfoRowView(user: user){
                    viewModel.addFriend(friendId: user.authId)
                    showingSearchSheet = false
                }
            }
        }
        .onChange(of: viewModel.searchTerm) { newValue in
            Task{
                await viewModel.search()
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewFriendSearchView(showingSearchSheet: .constant(false))
    }
}
