//
//  SingleHabitWidgetview.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 27/07/2023.
//

import WidgetKit
import SwiftUI

struct SingleHabitWidgetview : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: SingleHabitViewProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            Text("Nope")
        }
    }
}
