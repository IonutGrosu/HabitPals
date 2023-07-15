//
//  LoginView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
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
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Username", text: $username)
                    .padding ()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(10)
                SecureField("Password", text: $password)
                    .padding ()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(10)
                
                Button("Login") {
                    
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(10)
                
                Divider().padding()
                
                Button (action: {FirebaseAuthService.shared.googleSignIn(view: self)}) {
                    HStack{
                        Image("GoogleIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                        
                        Text("Sign in with Google")
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                            .padding(.leading)
                    }
                }
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.06))
                .cornerRadius(10)
                
            }
        }
        .navigationBarHidden(true)
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
