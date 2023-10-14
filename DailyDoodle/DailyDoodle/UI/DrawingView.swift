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
        NavigationView {
            HStack {
                ZStack {
                    // Left side: Canvas for drawing
                    Rectangle()
                    .stroke(Color.black, lineWidth: 2) // Border
                    .background(Color.white)
                    CanvasView(drawing: $drawing, penColor: selectedColor)
                        .background(Color.white)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    drawing.addPoint(point: value.location)
                                }
                        )
                        .border(Color.black, width: 5)
                        .frame(width: 100, height: 280, alignment: .leading)
                }

                // Right side: Panel for selecting pen color
                VStack {
                    Text("Pen Colors")
                        .font(.headline)
                        .padding()
                    ForEach(penColors, id: \.self) { color in
                        ColorButton(color: color, isSelected: color == selectedColor)
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
                .padding()
                .frame(width: 130, alignment: .trailing)
            }
        }
    }
}

struct CanvasView: View {
    @Binding var drawing: Drawing
    var penColor: Color
    
    var body: some View {
        ZStack {
            ForEach(drawing.lines) { line in
                Path { path in
                    for point in line.points {
                        path.addLine(to: point)
                    }
                }
                .stroke(line.color, lineWidth: line.width)
            }
        }
        .drawingGroup()
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
}

struct Line: Identifiable {
    var id = UUID()
    var color: Color
    var points: [CGPoint] = []
    var width: CGFloat = 5
}

#Preview {
    DrawingView()
}
