//
//  ColorMenuButton.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/17/23.
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
                    .frame(width: 100)
            }
            
            Spacer()
        }
    }
}
