//
//  UserProfileView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 20/07/2023.
//

import SwiftUI

struct UserProfileView: View {
    
    @Binding var user: DbUser
    
    var body: some View {
        VStack {
            if let urlString = user.pictureURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            Text(user.name ?? "No username available")
                .font(.title)
                .bold()
        }.padding()
    }
}
