//
//  AuthenticationService.swift
//  HabitPals
//
//  Created by Ionut Grosu on 16/07/2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let name: String?
    let email: String?
    let photoUrl: String?
    let isAnonymous: Bool
    
    init(user: User, googleSignInResult: GoogleSignInResultModel) {
        self.uid = user.uid
        self.name = googleSignInResult.name
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}

final class AuthenticationService {
    static let shared = AuthenticationService()
    
    private init() {}
    
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential, googleSignInResult: tokens)
    }
    
    func signIn(credential: AuthCredential, googleSignInResult: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user, googleSignInResult: googleSignInResult)
    }
    
    func getAuthenticatedUserId() throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return user.uid
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        UserDefaults.standard.setValue(false, forKey: "signedIn")
    }
}
