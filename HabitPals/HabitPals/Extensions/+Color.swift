//
//  +Color.swift
//  HabitPals
//
//  Created by Ionut Grosu on 20/07/2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryBackground = Color("SecondaryBackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}
