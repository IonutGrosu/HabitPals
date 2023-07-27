//
//  CompletedHabitsProgressCircleView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 23/07/2023.
//

import SwiftUI

struct CompletedHabitsProgressCircleView: View {
    
    var size: Double = 24.0
    var lineWidth: CGFloat = 8
    var progress: Double = 0.5
        
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.theme.accent.opacity(0.1), lineWidth: lineWidth)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: progress)
                .stroke(getProgressColor(), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
        }.frame(width: size, height: size)
    }
    
    func getProgressColor() -> Color {
        if progress == 1{
            return .green
        } else if progress >= 0.33 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    CompletedHabitsProgressCircleView()
}
