//
//  SelectUserIntent.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 23/07/2023.
//

import Foundation
import AppIntents

struct SelectUserIntent: AppIntent {
    static var title: LocalizedStringResource = "Complete Habit"
    
    init(){}
    
    
    func perform() async throws -> some IntentResult {
        
        
        
        return .result()
    }
}
