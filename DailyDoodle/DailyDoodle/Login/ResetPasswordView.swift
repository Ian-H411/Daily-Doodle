//
//  ResetPasswordView.swift
//  DailyDoodle
//
//  Created by Brody Sears on 10/19/23.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State var emailtext: String = ""
    @State var showResetMessage: Bool = false
    
    var body: some View {
        ZStack {
            //               GradientBackgroundView()
            Image("Gradient1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Reset your password")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                
                TextField("Username or Email address", text: $emailtext)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 45)
                    .padding()
                
                Button(action: {
                    // Action for "Submit" button = validate fields, then userAuth func for password reset: viewModel.resetPassword(emailText)
                    showResetMessage = true
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(100)
                }
                .padding()
                
                if showResetMessage {
                    Text("If an account exists for this Username/Email, we will send you a password reset email. Please check your email account.")
                        .font(.body)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Button(action: {
                    // Action for "Return to Login" button
                }) {
                    Text("Return to Login")
                        .font(.headline)
                        .frame(height: 45)
                        .foregroundColor(.white)
                        .underline()
                }
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
