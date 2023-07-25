//
//  HabitEntry.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 24/07/2023.
//

import WidgetKit

struct HabitsEntry: TimelineEntry {
    let date: Date
    let habits: [Habit]
    let configuration: ConfigurationAppIntent
}
