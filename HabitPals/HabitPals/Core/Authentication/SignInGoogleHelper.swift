//
//  SignInGoogleHelper.swift
//  HabitPals
//
//  Created by Ionut Grosu on 16/07/2023.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn(view: any View) async throws -> GoogleSignInResultModel {
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: view.getRootViewController())
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email

        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
    
}
