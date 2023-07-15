//
//  SymbolPicker.swift
//  HabitPals
//
//  Created by Ionut Grosu on 08/07/2023.
//

import SwiftUI

struct SymbolPicker: View {
    @Binding var selection: String
    @State private var isPresentingSheet = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        HStack {
            Text("Icon")
            Spacer()
            Image(systemName: selection)
        }
        .onTapGesture {
            isPresentingSheet = true
        }
        .sheet(isPresented: $isPresentingSheet) {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Symbols.SymbolsList, id: \.self) { value in
                        Image(systemName: value)
                            .font(.largeTitle)
                            .padding()
                            .onTapGesture {
                                selection = value
                                isPresentingSheet = false
                            }
                    }
                }
            }
        }
    }
    
    struct SymbolPicker_Previews: PreviewProvider {
        static var previews: some View {
            SymbolPicker(selection: .constant("book.closed.fill"))
        }
    }
}
