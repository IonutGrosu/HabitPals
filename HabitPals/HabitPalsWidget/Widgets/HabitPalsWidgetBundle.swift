//
//  HabitPalsWidgetBundle.swift
//  HabitPalsWidget
//
//  Created by Ionut Grosu on 25/07/2023.
//

import WidgetKit
import SwiftUI

@main
struct HabitPalsWidgetBundle: WidgetBundle {
    var body: some Widget {
        HabitPalsDailyProgressWidget()
        SingleHabitViewWidget()
    }
}
