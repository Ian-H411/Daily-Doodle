//
//  LoginView.swift
//  DailyDoodle
//
//  Created by Brody Sears on 10/19/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var usernameText: String = ""
    @State var passwordText: String = ""
    
    var body: some View {
           ZStack {
//               GradientBackgroundView() 
               Image("Gradient1")
                   .resizable()
                   .edgesIgnoringSafeArea(.all)
               
               VStack {
                   Text("Login to your account")
                       .font(.title)
                       .foregroundColor(.black)
                       .padding()
                   
                   TextField("Username or Email", text: $usernameText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .frame(height: 45)
                       .padding()
                   
                   SecureField("Password", text: $passwordText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .frame(height: 45)
                       .padding()
                   
                   Button(action: {
                       // Action for "Forgot your password?" button = show ResetPasswordView
                   }) {
                       Text("Forgot your password?")
                           .foregroundColor(.white)
                           .underline()
                   }
                   .padding()
                   
                   Button(action: {
                       // Action for "Continue" button = validate fields, then login and userAuth funcs: viewModel.login(usernameText, passwordText)
                   }) {
                       Text("CONTINUE")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding()
                           .frame(height: 45)
                           .frame(maxWidth: .infinity)
                           .background(Color.blue)
                           .cornerRadius(100)
                   }
                   .padding()
                   
                   Text("New to Daily Doodle?")
                       .font(.headline)
                       .fontWeight(.light)
                       .foregroundColor(.white)
                   
                   Button(action: {
                       // Action for "Create an Account" button
                   }) {
                       Text("Create an Account")
                           .font(.headline)
                           .foregroundColor(.white)
                           .underline()
                   }
               }
           }
       }
}

#Preview {
    LoginView()
}
