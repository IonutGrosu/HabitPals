//
//  SingleHabitEntry.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 27/07/2023.
//

import WidgetKit

struct SingleHabitEntry: TimelineEntry {
    let date: Date
    let habit: Habit
    let configuration: SingleHabitConfigurationAppIntent
}
