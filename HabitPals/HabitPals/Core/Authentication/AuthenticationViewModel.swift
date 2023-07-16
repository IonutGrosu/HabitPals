//
//  AuthenticationViewModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 16/07/2023.
//

import Foundation
import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle(view: any View) async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn(view: view)
        let authDataResult = try await AuthenticationService.shared.signInWithGoogle(tokens: tokens)
        let user = DbUser(auth: authDataResult)
        try await UserRepository.shared.createNewUser(user: user)
        
        UserDefaults.standard.setValue(true, forKey: "signedIn")
    }

}
