//
//  CreateAccountView.swift
//  DailyDoodle
//
//  Created by Brody Sears on 10/19/23.
//

import SwiftUI

struct CreateAccountView: View {
    
    @State var usernameText: String = ""
    @State var emailText: String = ""
    @State var passwordText: String = ""
    
    var body: some View {
           ZStack {
//               GradientBackgroundView()
               Image("Gradient1")
                   .resizable()
                   .edgesIgnoringSafeArea(.all)
               
               VStack {
                   Text("Create your Daily Doodle account")
                       .font(.title)
                       .foregroundColor(.black)
                       .padding()
                   
                   TextField("@Username", text: $usernameText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
                   
                   TextField("Email", text: $usernameText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
                   
                   SecureField("Password", text: $passwordText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
                   
                   Button(action: {
                       // Action for "Forgot your password?" button = show ResetPasswordView
                   }) {
                       Text("Terms and Conditions")
                           .foregroundColor(.white)
                           .underline()
                   }
                   .padding()
                   
                   Button(action: {
                       // Action for "Continue" button = validate fields, then createUser and userAuth funcs: viewModel.createUser(usernameText, emailText, passwordText)
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
               }
           }
       }
}

#Preview {
    CreateAccountView()
}
