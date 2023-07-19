//
//  AccountView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import SwiftUI


struct AccountView: View {
    
    @StateObject private var viewModel = AccountViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let userName = viewModel.currentUser.name?.description {
                    Text(userName)
                }
                
                
                Button(action: {
                    do {
                        try AuthenticationService.shared.signOut()
                    } catch{}
                }, label: {
                    Text("Logout")
                }).buttonStyle(.bordered)
            }
            .task {
                await viewModel.fetchCurrentAccount()
            }
        }
    }
}

#Preview {
    AccountView()
}
