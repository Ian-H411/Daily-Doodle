//
//  Gradient Background.swift
//  DailyDoodle
//
//  Created by Brody Sears on 10/19/23.
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.red, .blue, .green, .purple, .red]),
                                center: .center,
                                startAngle: .degrees(0),
                                endAngle: .degrees(360))
            }
            .edgesIgnoringSafeArea(.all) 
        }
}

#Preview {
    GradientBackgroundView()
}
