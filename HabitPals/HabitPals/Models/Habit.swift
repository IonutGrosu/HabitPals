//
//  Habit.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id: UUID
    var name: String
    var icon: String
    var completedNumberOfDays: Double
    var completedNumberOfDaysAsInt: Int {
        return Int(completedNumberOfDays)
    }
    var totalNumberOfDays: Double
    var totalNumberOfDaysAsInt: Int {
        return Int(totalNumberOfDays)
    }
    var lastCompletionDate: Date
    
    var isCompletedToday: Bool {
        return Calendar.current.isDate(lastCompletionDate, equalTo: Date.now, toGranularity: .day)
    }
    
    init(id: UUID = UUID(), name: String, icon: String, totalNumberOfDays: Double, completedNumberOfDays: Double = 0, lastCompletionDate: Date = addOrSubtractDay(day: -1)) {
        self.id = id
        self.name = name
        self.icon = icon
        self.completedNumberOfDays = completedNumberOfDays
        self.totalNumberOfDays = totalNumberOfDays
        self.lastCompletionDate = lastCompletionDate
    }
    
    mutating func completeToday() {
        self.lastCompletionDate = Date()
        completedNumberOfDays += 1
    }
}

extension Habit {
    
    static let sampleData: [Habit] = [
        Habit(name: "Read 20 pages per day", icon: "book.closed.fill", totalNumberOfDays: 21),
        Habit(name: "Wake up before 8 AM", icon: "alarm.fill", totalNumberOfDays: 21),
        Habit(name: "Meditate for 5 minutes", icon: "figure.mind.and.body", totalNumberOfDays: 21),
        Habit(name: "Get sunlight", icon: "sun.min.fill", totalNumberOfDays: 21)
    ]
    
    static var emptyHabit: Habit {
        Habit(name: "", icon: "circle", totalNumberOfDays: 20)
    }
    
    var dictionary: [String: Any] {
        return [
            "id": self.id.uuidString,
            "name": self.name,
            "icon": self.icon,
            "completedNumberOfDays": self.completedNumberOfDays,
            "totalNumberOfDays": self.totalNumberOfDays,
            "lastCompletionDate": self.lastCompletionDate,
        ]
    }
    
}
