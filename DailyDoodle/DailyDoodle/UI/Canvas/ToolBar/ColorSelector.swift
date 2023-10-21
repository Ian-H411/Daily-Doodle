//
//  ColorSelector.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/15/23.
//

import SwiftUI

struct ColorSelector: View {
    
    @State private var colorValue: Double = 0.0
    @Binding var currentColor: Color
    
    let colorArray: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .black]
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: colorArray),
                               startPoint: .top,
                               endPoint: .bottom)
                .frame(width: 20, height: 200)
                .cornerRadius(10)
                Circle()
                    .fill(currentColor)
                    .frame(width: 30, height: 30)
                    .offset(y: CGFloat(colorValue) * 200)
                    .overlay(content: {
                        Circle()
                            .fill(currentColor)
                            .frame(width: 30, height: 30)
                            .offset(y: CGFloat(colorValue) * 200)
                            .shadow(color: Color.gray, radius: 5, x: 0, y: 4)
                    })
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let offsetY = value.location.y
                                let totalHeight: CGFloat = 200
                                let colorValueForTracking = min(max(offsetY / totalHeight, 0.0), 1.0) - 0.5
                                let percentage = colorValueForTracking + 0.5
                                let sectionCount = colorArray.count - 1
                                let sectionSize = 1.0 / Double(sectionCount)
                                let section = min(max(Int(percentage / sectionSize), 0), sectionCount - 1)
                                let sectionPercentage = (percentage - (sectionSize * Double(section))) / sectionSize
                                let newColor = colorArray[section].interpolateColor(to: colorArray[section + 1], percentage: sectionPercentage)
                                currentColor = newColor
                                self.colorValue = Double(colorValueForTracking)
                            }
                    )
            }
        }
    }
}

extension Color {
    func interpolateColor(to destination: Color, percentage: Double) -> Color {
        return Color(
            red: self.rgbComponents.red + (destination.rgbComponents.red - self.rgbComponents.red) * percentage,
            green: self.rgbComponents.green + (destination.rgbComponents.green - self.rgbComponents.green) * percentage,
            blue: self.rgbComponents.blue + (destination.rgbComponents.blue - self.rgbComponents.blue) * percentage
        )
    }
}

extension Color {
    var rgbComponents: (red: Double, green: Double, blue: Double) {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (Double(red), Double(green), Double(blue))
    }
}
