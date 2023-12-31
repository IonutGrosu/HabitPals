//
//  HabitRepository.swift
//  HabitPals
//
//  Created by Ionut Grosu on 14/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore
import WidgetKit

struct HabitRepository {
    static let shared = HabitRepository()
    
    private init(){}
    
    func dbRef() -> Firestore {
        return Firestore.firestore()
    }
    
    func habitDocumentRef(userId: String, habitId: String) -> DocumentReference {
        return dbRef().collection("users/").document(userId).collection("habits").document(habitId)
    }
    
    func habitsCollectionRef(userId: String) -> CollectionReference {
        return dbRef().collection("users/").document(userId).collection("habits")
    }
    
    func saveHabit(habit: Habit, userId: String) throws {
        try habitDocumentRef(userId: userId, habitId: habit.id.uuidString).setData(from: habit)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func addListenerForHabitsByUserId(userId: String, completion: @escaping (_ habits: [Habit]) -> Void) {
        
        habitsCollectionRef(userId: userId).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            let habits: [Habit] = documents.compactMap({try? $0.data(as: Habit.self)})
            
            completion(habits)
        }
    }
    
    
    func fetchHabitsForUserId(userId: String) async -> [Habit] {
        
        var habits: [Habit] = []
        
        do {
            let snapshot = try await habitsCollectionRef(userId: userId).getDocuments()
            
            habits = snapshot.documents.compactMap({try? $0.data(as: Habit.self)})
            
        } catch {}
                
        return habits
    }
    
    func fetchHabitWithId(habitId: String, userId: String) async -> Habit {
        
        var habit: Habit = Habit.emptyHabit
        
        do {
            habit = try await habitDocumentRef(userId: userId, habitId: habitId).getDocument(as: Habit.self)
        } catch {
            print("Problem fetching a single habit")
        }
        
        return habit
    }
}
