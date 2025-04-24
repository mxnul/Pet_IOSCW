//
//  Login2.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-24.
//

import SwiftUI
import FirebaseAuth

struct Login2: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var isLoggedIn: Bool = false // Track login status

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .foregroundColor(.customLightGray)
                    .frame(width: 80, height: 80)
                    .padding(.top, 60)

                Text("Pet Locator")
                    .font(.title)
                    .foregroundColor(.customLightGray)
                    .bold()

                TextField("Email", text: $email)
                    .foregroundColor(.customLightGray)
                    .keyboardType(.emailAddress)
                    .padding()
                    .foregroundColor(.customLightGray)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.customLightGray, lineWidth: 1))
                    .padding(.top, 30)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(.customLightGray)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.customLightGray, lineWidth: 1))
                    .padding(.top, 30)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }

                Button(action: signIn) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.customLightGray)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
                .disabled(isLoading)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.black)
          

            // Navigate to MainTabView if login is successful
            .background(
                NavigationLink(destination: MainTabView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }

    func signIn() {
        isLoading = true
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                // If login is successful, set isLoggedIn to true to trigger navigation
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    Login2()
}

