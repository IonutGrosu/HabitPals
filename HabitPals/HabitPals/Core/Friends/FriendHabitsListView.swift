//
//  FriendHabitsView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 19/07/2023.
//

import SwiftUI

struct FriendHabitsListView: View {
    let nonCompletedCheckmark: String = "checkmark.circle"
    let completedCheckmark: String = "checkmark.circle.fill"
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = FriendHabitsListViewModel()
    
    @State var friend: DbUser
    
    var body: some View {
        VStack {
            // MARK: Friend profile
            VStack {
                if let urlString = friend.pictureURL, let url = URL(string: urlString) {
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
                Text(friend.name ?? "No username available")
                    .font(.title)
                    .bold()
                Button(action: {
                    FriendsRepository.shared.removeFriend(friendId: friend.authId)
                    dismiss()
                }, label: {
                    Text("Remove friend")
                }).buttonStyle(.bordered)
            }.padding()
            
            // MARK: Friend habits list
            List{
                ForEach($viewModel.habits) { $habit in
                    HStack {
                        Image(systemName: habit.icon)
                            .font(.title2)
                        
                        Text(habit.name)
                            .font(.title)
                        Spacer()
                        Image(systemName: habit.isCompletedToday==true ? completedCheckmark : nonCompletedCheckmark)
                            .font(.title)
                            .foregroundColor(habit.isCompletedToday==true ? .green : .red)
                    }
                    .padding(
                        EdgeInsets(
                            top: 25,
                            leading: 5,
                            bottom: 25,
                            trailing: 5
                        )
                    )
                }
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .background(.clear)
                        .foregroundColor(Color("BackgroundColor"))
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10
                            )
                        )
                )
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .task{
                await viewModel.fetchHabits(userId: friend.authId)
            }
        }
    }
}

#Preview {
    FriendHabitsListView(friend: DbUser(name: "Ionut-Florentin Grosu", email: "ionutflorentin.grosu@gmail.com", authId: "1msUzhVHNTQQr0U5IQ84VPzMHKQ2", pictureURL: "https://lh3.googleusercontent.com/a/AAcHTtfeoFx7CNvXN720R6xLunkZNpstYeizSo_B0y6QT0dmejk=s96-c"))
}
