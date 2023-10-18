//
//  ColorSelector.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/15/23.
//

import SwiftUI

struct ColorSelector: View {
    let penColors: [Color] = [.black, .red, .green, .blue, .orange]
    @Binding var selectedColor: Color
    
    var body: some View {
        VStack {
            Text("Pen Colors")
                .font(.headline)
                .padding()
                .foregroundStyle(.black)
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
