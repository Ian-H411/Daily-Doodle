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

#Preview {
    DrawingView()
}
