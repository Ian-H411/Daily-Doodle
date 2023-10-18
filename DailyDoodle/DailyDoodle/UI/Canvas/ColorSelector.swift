//
//  ColorSelector.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/15/23.
//

import SwiftUI

struct ColorMenuButton: View {
    @State var isSelectorExpanded = false
    @Binding var selectedColor: Color
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isSelectorExpanded.toggle()
                }
            }) {
                Text(isSelectorExpanded ? "-" : "+")
                    .font(.title)
            }
            
            if isSelectorExpanded {
                ColorSelector(selectedColor: $selectedColor)
                    .frame(width: 100) // Adjust the width to your preference
            }
            
            Spacer()
        }
    }
}

struct ColorSelector: View {
    let penColors: [Color] = [.black, .red, .green, .blue, .orange]
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack {
            Text("Pen Colors")
                .font(.headline)
                .padding()
            ForEach(penColors, id: \.self) { color in
                ColorButton(color: color, isSelected: color == selectedColor)
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

struct ColorButton: View {
    var color: Color
    var isSelected: Bool
    
    var body: some View {
        let selectedColor: Color = color == Color.black ? Color.gray : Color.black
        color
            .frame(width: 40, height: 40)
            .cornerRadius(20)
            .overlay(
                Circle()
                    .stroke(isSelected ? selectedColor : Color.clear, lineWidth: 2)
            )
    }
}
