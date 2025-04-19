//
//  Login.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI

//extension Color {
//    static let customLightGray = Color(red:235/255, green:235/255, blue: 245/255)
//}
struct Login : View {
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            Image (systemName: "pawprint.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.customLightGray)
            
            Text("Get Started")
                .font(.title2)
                .foregroundColor(.customLightGray)
            
            Button("Login"){
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .background(Color.customLightGray)
            .cornerRadius(10)
            
            
        Button("Login with Apple"){
        }
//        .buttonStyle(SocialButtonStyle (icon: "applelogo"))
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .background(Color.customLightGray)
        .cornerRadius(10)
        
        Button("Login with Google"){
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .background(Color.customLightGray)
        .cornerRadius(10)
        
        Text(" By continuing you agree to our Terms & Privacy Policy")
            .font(.footnote)
            .foregroundColor(.customLightGray)
            .padding(.top, 10)
        
        Spacer()
            
        }
        .padding()
        .background(Color.black)
        .ignoresSafeArea()
    }
}



#Preview {
    Login()
}
