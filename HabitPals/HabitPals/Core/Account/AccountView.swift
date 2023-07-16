//
//  AccountView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject private var viewModel = AccountViewModel()
    
    @AppStorage("loggedInUser") private var localUser: Data = Data()
    @State private var user: DbUser = DbUser.emptyUser
    
    var body: some View {
        NavigationStack {
            VStack {

                Button(action: {
                    do {
                        try AuthenticationService.shared.signOut()
                    } catch{}
                }, label: {
                    Text("Logout")
                }).buttonStyle(.plain)
            }.onAppear{
                guard let user = try? JSONDecoder().decode(DbUser.self, from: localUser) else {return}
                self.user = user
            }
        }
    }
}

#Preview {
    AccountView()
}
