//
//  DrawingView.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/13/23.
//

import SwiftUI

struct DrawingView: View {
    @State private var drawing = Drawing()
    @State var colorSelected: Color = .red
    @State var strokeWidth: Double = 12.5
    @State var isColorMenuDisplayed: Bool = false
    
    var body: some View {
        ZStack {
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
                    isColorMenuDisplayed = false
                    let newPoint = value.location
                    drawing.addPoint(point: newPoint, color: colorSelected, strokeWidth: strokeWidth)
                })
                    .onEnded({ value in
                        self.drawing.newLine(color: colorSelected, strokeWidth: strokeWidth)
                    }))
            HStack {
                Spacer()
                ColorSelector(currentColor: $colorSelected)
                    .frame(width: 50, height: 500 ,alignment: .top)
            }
            
        }
    }
}

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

#Preview {
    DrawingView()
}
