//
//  FriendHabitsInfoRowView.swift
//  HabitPals
//
//  Created by Ionut Grosu on 18/07/2023.
//

@MainActor
final class FriendHabitsInfoRowViewModel: ObservableObject {
    
    @Published var completedTodaysHabits: Bool = true
    @Published var totalOngoingHabits: Int = 0
    @Published var habitsCompletedToday: Int = 0
    
    func fetchUserHabitsInfo(userId: String) async {
        let habits = await HabitRepository.shared.fetchHabitsForUserId(userId: userId)
        print(habits)
        
        habits.forEach { habit in
            totalOngoingHabits += 1
            
            if !habit.isCompletedToday {
                completedTodaysHabits = false
            } else {
                habitsCompletedToday += 1
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
                ZStack {
                    HabitsCompletionStatusArc(totalOngoingHabits: Double(viewModel.totalOngoingHabits), habitsCompletedToday: Double(viewModel.habitsCompletedToday))
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
            }
            
            VStack(alignment: .leading) {
                Text(friend.name ?? "")
                    .font(.title2)
                
                Text("Completed \(viewModel.habitsCompletedToday) out of \(viewModel.totalOngoingHabits) habits today")
                    .font(.caption2)
            }
            .padding(.leading, 4)
        }.task{
            await viewModel.fetchUserHabitsInfo(userId: friend.authId)
        }
    }
}

#Preview {
    FriendHabitsInfoRowView(friend: DbUser(name: "Ionut-Florentin Grosu", email: "ionutflorentin.grosu@gmail.com", authId: "aKDrkWarl2UfI7vjfTrOOMhWAul1", pictureURL: "https://lh3.googleusercontent.com/a/AAcHTtfeoFx7CNvXN720R6xLunkZNpstYeizSo_B0y6QT0dmejk=s96-c"))
}
