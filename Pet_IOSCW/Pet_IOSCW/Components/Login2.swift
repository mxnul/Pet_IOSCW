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
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .foregroundColor(.customLightGray)
                    .frame(width: 100, height: 100)
                    .padding(.top, 60)

                Text("Pet Locator")
                    .font(.title)
                    .foregroundColor(.customLightGray)
                    .bold()
                    .padding(.bottom, 35)

               
                TextField("", text: $email, prompt: Text("Email").foregroundColor(.gray))
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.customLightGray, lineWidth: 1)
                    )
                    .padding(.top, 30)

               
                SecureField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.customLightGray, lineWidth: 1)
                    )
                    .padding(.top, 30)
                    .padding(.bottom, 30)  

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
                            .frame(width: 350)
                            .padding()
                            .background(Color.customLightGray)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                }
                .disabled(isLoading)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.black)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
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
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    Login2()
}
