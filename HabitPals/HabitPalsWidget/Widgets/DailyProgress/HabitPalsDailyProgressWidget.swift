//
//  HabitPalsDailyProgressWidget.swift
//  HabitPalsWidget
//
//  Created by Ionut Grosu on 25/07/2023.
//

import WidgetKit
import SwiftUI

struct HabitPalsDailyProgressWidget: Widget {
    let kind: String = "HabitPalsDailyProgressWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: DailyProgressConfigurationAppIntent.self, provider: DailyProgressHabitsProvider()) { entry in
            DailyProgressWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemSmall, .systemLarge])
    }
}
