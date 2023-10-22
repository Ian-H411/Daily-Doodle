//
//  Drawing.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/22/23.
//

import SwiftUI

struct Drawing {
    var lines: [Line] = []
    
    mutating func addPoint(point: CGPoint, color: Color, strokeWidth: Double) {
        if lines.isEmpty {
            lines.append(Line(color: color, width: strokeWidth))
        }
        lines[lines.count - 1].points.append(point)
        lines[lines.count - 1].color = color
        lines[lines.count - 1].width = strokeWidth
    }
    
    mutating func newLine(color: Color, strokeWidth: Double) {
        lines.append(Line(color: color, width: strokeWidth))
    }
}

struct Line: Identifiable {
    var id = UUID()
    var color: Color = .white
    var points: [CGPoint] = []
    var width: CGFloat
}
