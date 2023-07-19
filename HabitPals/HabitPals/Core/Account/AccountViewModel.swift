//
//  AccountViewModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation
import GoogleSignIn

@MainActor
final class AccountViewModel: ObservableObject {
    
    @Published var currentUser: DbUser = DbUser.emptyUser

    func fetchCurrentAccount() async {
        guard let userId = try? AuthenticationService.shared.getAuthenticatedUserId() else {return}

        do {
            currentUser =  try await UserRepository.shared.getUser(userId)
        }catch{}
    }
}
