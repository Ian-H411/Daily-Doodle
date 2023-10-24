//
//  LandingView.swift
//  DailyDoodle
//
//  Created by Brody Sears on 10/19/23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack {
//            GradientBackgroundView()
            Image("Gradient1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("WELCOME TO")
                    .font(.title)
                    .fontWeight(.ultraLight)
                
                Text("DAILY")
                    .font(.system(size: 50))
                    .font(.largeTitle)
                    .fontWeight(.light)
                
                Text("DOODLE")
                    .font(.system(size: 50))
                    .font(.largeTitle)
                    .fontWeight(.light)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        // Log in button action = Show the loginview
                    }) {
                        Text("LOG IN")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.black, lineWidth: 1)
                                
                            )
                    }
                    .padding()
                    
                    Button(action: {
                        // Sign up button action = show the CreateAccountView
                    }) {
                        Text("SIGN UP")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(50)
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    LandingView()
}
