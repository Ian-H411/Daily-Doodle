//
//  DrawingView.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/13/23.
//

import SwiftUI

struct DrawingView: View {
    @State private var drawing = Drawing()
    @State private var selectedColor = Color.black
    let penColors: [Color] = [.black, .red, .green, .blue, .orange]
    
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
                    drawing.addPoint(point: newPoint)
                })
                    .onEnded({ value in
                        self.drawing.newLine()
                    }))
        }
    }
}

struct ColorButton: View {
    var color: Color
    var isSelected: Bool
    
    var body: some View {
        color
            .frame(width: 40, height: 40)
            .cornerRadius(20)
            .overlay(
                Circle()
                    .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2)
            )
    }
}


struct Drawing {
    var lines: [Line] = []
    
    mutating func addPoint(point: CGPoint) {
        if lines.isEmpty {
            lines.append(Line(color: .black))
        }
        lines[lines.count - 1].points.append(point)
    }
    
    mutating func newLine() {
        lines.append(Line(color: .black))
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
