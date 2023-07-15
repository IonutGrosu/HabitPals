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
    @State private var user: User = User.emptyUser
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: user.pictureURL)) { image in
                    image.resizable()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                Text(user.name)
                    .font(.title)
                    .padding()
                Text(user.authId)
                Button(action: FirebaseAuthService.shared.logout, label: {
                    Text("Logout")
                }).buttonStyle(.plain)
            }.onAppear{
                guard let user = try? JSONDecoder().decode(User.self, from: localUser) else {return}
                self.user = user
            }
        }
    }
}

#Preview {
    AccountView()
}
