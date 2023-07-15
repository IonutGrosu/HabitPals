//
//  FirebaseAuthService.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUI

struct FirebaseAuthService {
    
    static let shared = FirebaseAuthService()
    
    private init(){}

    func googleSignIn(view: any View) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: view.getRootViewController()) { result, error in
            if error != nil {
                // ...
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    //TODO - manage error
                    return
                }
                
                let newUser = User(name: result?.user.displayName ?? "", email: result?.user.email ?? "", authId: result?.user.uid ?? "", pictureURL: result?.user.photoURL?.absoluteString ?? "")
                                
                UserRepository.shared.saveAccount(user: newUser)
                
                UserDefaults.standard.set(true, forKey: "signedIn")
            }
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set(false, forKey: "signedIn")
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getAuthenticatedUserId() -> String {
        let uid = Auth.auth().currentUser?.uid ?? ""
        return uid
    }
}
