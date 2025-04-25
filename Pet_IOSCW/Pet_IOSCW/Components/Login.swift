//
//  Login.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//
import SwiftUI

struct Login: View {
    @State private var navigateToLogin2 = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.customLightGray)
                    .padding(.bottom, 50)

                HStack {
                    Text("Get Started")
                        .font(.title)
                        .bold()
                        .foregroundColor(.customLightGray)
                    Spacer()
                }
                .padding(.horizontal)

                
                NavigationLink(destination: Login2(), isActive: $navigateToLogin2) {
                    EmptyView()
                }

                Button("Login") {
                    navigateToLogin2 = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .background(Color.customLightGray)
                .cornerRadius(20)
                .padding(.bottom)

                VStack(alignment: .leading, spacing: 4) {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 400, height: 2)
                        .padding(.leading, 8)
                }

                Button("Login with Face ID") {
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .background(Color.customLightGray)
                .cornerRadius(20)
                .padding(.top)
                .padding(.bottom, 10)

                Button("Login with Apple ID") {
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .background(Color.customLightGray)
                .cornerRadius(20)

                Text("By continuing you agree to our Terms & Privacy Policy")
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
}


#Preview {
    Login()
}
