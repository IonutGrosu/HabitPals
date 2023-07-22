//
//  LargeWidgetView.swift
//  HabitPalsWidgetExtension
//
//  Created by Ionut Grosu on 22/07/2023.
//

import SwiftUI
import WidgetKit

struct LargeWidgetView: View {
    var entry: SimpleEntry
    
    var body: some View {
        ForEach(0...3, id: \.self) { _ in
            HStack{
                Image(systemName: "figure.mind.and.body")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                Text("Meditate for 5 minutes")
                    .font(.title3)
                Spacer()
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }.padding()
            Divider()
        }
    }
}
