//
//  HabitPalsWidget.swift
//  HabitPalsWidget
//
//  Created by Ionut Grosu on 22/07/2023.
//

import WidgetKit
import SwiftUI

struct HabitPalsWidget: Widget {
    let kind: String = "HabitPalsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WidgetView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .configurationDisplayName("HabitPals")
        .description("Stay on top of your habits and check on your friends.")
    }
}

#Preview(as: .systemSmall) {
    HabitPalsWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
