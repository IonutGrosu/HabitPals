//
//  SingleHabitViewWidget.swift
//  HabitPalsWidget
//
//  Created by Ionut Grosu on 27/07/2023.
//

import WidgetKit
import SwiftUI

struct SingleHabitViewWidget: Widget {
    let kind = "SingleHabitViewWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SingleHabitConfigurationAppIntent.self, provider: SingleHabitViewProvider()) { entry in
            SingleHabitWidgetview(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemMedium])
    }
    
    
}
