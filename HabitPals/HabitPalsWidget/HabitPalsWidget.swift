//
//  HabitPalsWidget.swift
//  HabitPalsWidget
//
//  Created by Ionut Grosu on 25/07/2023.
//

import WidgetKit
import SwiftUI

struct HabitPalsWidget: Widget {
    let kind: String = "HabitPalsWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
