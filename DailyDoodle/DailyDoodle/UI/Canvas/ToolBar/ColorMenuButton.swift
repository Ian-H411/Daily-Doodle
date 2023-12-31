//
//  ColorMenuButton.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/17/23.
//

import SwiftUI

struct ColorMenuButton: View {
    @Binding var isSelectorExpanded: Bool
    @Binding var selectedColor: Color
    @Binding var strokeWidth: Double
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    isSelectorExpanded.toggle()
                }
            }) {
                Text(isSelectorExpanded ? "-" : "+")
                    .font(.title)
            }
            
            if isSelectorExpanded {
                ColorSelector(currentColor: $selectedColor)
                    .frame(width: 100)
                StrokeWidthSelector(value: $strokeWidth)
            } else {
                Spacer()
            }
        }
    }
}
