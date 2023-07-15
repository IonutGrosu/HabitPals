//
//  HabitPalsApp.swift
//  HabitPals
//
//  Created by Ionut Grosu on 15/07/2023.
//

import SwiftUI

@main
struct HabitPalsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("signedIn") var isSignedIn = false
    
//    @StateObject private var store = HabitStore()
    
    var body: some Scene {
        WindowGroup {
            if !isSignedIn {
                LoginView()
            } else {
                RootView()
            }
        }
        
    }
}
