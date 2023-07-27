//
//  DailyProgressWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import WidgetKit
import SwiftUI

struct DailyProgressWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: DailyProgressHabitsProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemLarge:
            LargeWidgetView(entry: entry )
        default:
            Text("Nope")
        }
    }
}
