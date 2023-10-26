//
//  ProfileView.swift
//  DailyDoodle
//
//  Created by Ian Hall on 10/23/23.
//

import SwiftUI

struct ProfileView: View {
    //TODO: -- replace with non static profile 
    @State var userProfile: UserProfile = UserProfile(json: [String: Any]())
    
    var body: some View {
        ScrollView {
            ProfileHeaderView()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), alignment: .leading, spacing: 0) {
                ForEach(0..<20, id: \.self) { index in
                    let drawing = userProfile.drawings[index]
                    DrawingDisplayView(drawing: drawing)
                }
            }
        }
    }
}

private struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            Image("")
            VStack {
                Button("add friend") {
                    // add friend button here
                }
                Text("UserName here")
                Text("quirky profile desc here")
            }
        }
    }
}

struct DrawingDisplayView: View {
    
    var drawing: Drawing
    
    var body: some View {
        GeometryReader { geometry in
             ZStack {
                 ForEach(drawing.lines) { line in
                     Path { path in
                         for point in line.points {
                             let x = point.x * geometry.size.width
                             let y = point.y * geometry.size.height
                             if path.isEmpty {
                                 path.move(to: CGPoint(x: x, y: y))
                             } else {
                                 path.addLine(to: CGPoint(x: x, y: y))
                             }
                         }
                     }
                     .stroke(line.color, lineWidth: line.width)
                 }
             }
         }
    }
}

#Preview(body: {
    ProfileView()
})
