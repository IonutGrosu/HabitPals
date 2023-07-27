//
//  HabitsListEntry.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 24/07/2023.
//

import WidgetKit

struct HabitsListEntry: TimelineEntry {
    let date: Date
    let habits: [Habit]
    let user: WidgetDbUser
    let configuration: DailyProgressConfigurationAppIntent
}
