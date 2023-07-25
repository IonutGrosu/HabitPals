//
//  AuthDataResultModel.swift
//  HabitPals
//
//  Created by Ionut Grosu on 25/07/2023.
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
