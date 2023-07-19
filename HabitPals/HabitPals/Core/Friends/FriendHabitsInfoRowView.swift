//
//  FriendHabitsInfoRowView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 18/07/2023.
//

final class FriendHabitsInfoRowViewModel: ObservableObject {
    
    @Published var completedTodaysHabits: Bool = true
    
    func fetchUserHabitsInfo(userId: String) async {
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        print(habits)
        
        habits.forEach { habit in
            if !habit.isCompletedToday {
                completedTodaysHabits = false
                print("false")
            }
        }
    }
}

import SwiftUI

struct FriendHabitsInfoRowView: View {
    @ObservedObject var viewModel = FriendHabitsInfoRowViewModel()
    @State var friend: DbUser
    
    var body: some View {
        HStack {
            if let urlString = friend.pictureURL, let url = URL(string: urlString) {
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
                Text(friend.name ?? "")
                    .font(.title2)
                
                Label(
                    title: { Text("Completed today's habits") },
                    icon: {
                        if viewModel.completedTodaysHabits {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(.green))
                        } else {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(Color(.red))
                        }
                    }
                )
            }
            .padding(.leading, 4)
        }.task{
            await viewModel.fetchUserHabitsInfo(userId: friend.authId)
        }
    }
}

#Preview {
    FriendHabitsInfoRowView(friend: DbUser(name: "Ionut-Florentin Grosu", email: "ionutflorentin.grosu@gmail.com", authId: "1msUzhVHNTQQr0U5IQ84VPzMHKQ2", pictureURL: "https://lh3.googleusercontent.com/a/AAcHTtfeoFx7CNvXN720R6xLunkZNpstYeizSo_B0y6QT0dmejk=s96-c"))
}
