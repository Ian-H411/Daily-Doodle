//
//  DrawingView.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/13/23.
//

import SwiftUI

struct DrawingView: View {
    @State private var drawing = Drawing()
    var colorSelector = ColorSelector()
    
    var body: some View {
        HStack {
            Canvas { context, size in
                for line in drawing.lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path,
                                   with: .color(line.color),
                                   lineWidth: line.width)
                }
            }
            .background(.white)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
                    drawing.addPoint(point: newPoint, color: colorSelector.selectedColor)
                })
                    .onEnded({ value in
                        self.drawing.newLine(color: colorSelector.selectedColor)
                    }))
            colorSelector
        }
    }
}

struct Drawing {
    var lines: [Line] = []
    
    mutating func addPoint(point: CGPoint, color: Color) {
        if lines.isEmpty {
            lines.append(Line(color: color))
        }
        lines[lines.count - 1].points.append(point)
    }
    
    mutating func newLine(color: Color) {
        lines.append(Line(color: color))
    }
}

struct Line: Identifiable {
    var id = UUID()
    var color: Color = .white
    var points: [CGPoint] = []
    var width: CGFloat = 1.0
}

#Preview {
    DrawingView()
}
