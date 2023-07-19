//
//  UserSearchInfoRowView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 18/07/2023.
//

import SwiftUI

struct UserSearchInfoRowView: View {
    
    @State var user: DbUser
    
    var addFriendAction: () -> Void
    
    var body: some View {
        
        HStack {
            if let urlString = user.pictureURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading) {
                Text(user.name ?? "")
                    .font(.title2)
                Text(user.email ?? "")
                    .font(.caption)
            }
            .padding(.leading, 4)
            Spacer()
            Button {
                addFriendAction()
            } label: {
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            }
        }
    }
}

#Preview {
    UserSearchInfoRowView(user: DbUser(name: "Ionut-Florentin Grosu", email: "ionutflorentin.grosu@gmail.com", authId: "1msUzhVHNTQQr0U5IQ84VPzMHKQ2", pictureURL: "https://lh3.googleusercontent.com/a/AAcHTtfeoFx7CNvXN720R6xLunkZNpstYeizSo_B0y6QT0dmejk=s96-c"), addFriendAction: {})
        .previewLayout(.sizeThatFits)
}
