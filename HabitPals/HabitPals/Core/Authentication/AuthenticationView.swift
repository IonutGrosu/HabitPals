//
//  AuthenticationView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 16/07/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var vm = AuthenticationViewModel()
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.35))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .padding()
                
                Button (action: {
                    Task {
                        do {
                            try await vm.signInGoogle(view: self)
                        } catch {
                            print(error)
                        }
                    }
                }) {
                    HStack{
                        Image("GoogleIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                        
                        Text("Sign In With Google")
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                            .padding(.leading)
                    }
                }
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.06))
                .cornerRadius(10)
                .padding()
                
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AuthenticationView()
}
