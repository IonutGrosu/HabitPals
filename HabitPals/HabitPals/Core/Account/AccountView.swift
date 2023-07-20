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
                
                UserProfileView(user: $viewModel.currentUser)
                
                
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
