//
//  StrokeWidthSelector.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/17/23.
//

import SwiftUI

struct StrokeWidthSelector: View {
    @Binding var value: Double

    var body: some View {
        VStack {
            Text("Value: \(value, specifier: "%.1f")")
                .padding()
                .foregroundStyle(.black)

            Slider(value: $value, in: 5...20)
                .rotationEffect(.degrees(-90))
                .frame(width: 100)
        }
    }
}
