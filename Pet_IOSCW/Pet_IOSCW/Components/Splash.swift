//
//  Splash.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI

extension Color {
    static let customLightGray = Color(red:235/255, green:235/255, blue: 245/255)
}

struct Splash: View {
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                if isActive {
                    Login()
                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "pawprint.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.customLightGray)
                            .padding()

                        Text("Pet Locator")
                            .font(.title)
                            .bold()
                            .foregroundColor(.customLightGray)

                        Text("find your furball in a flash!")
                            .foregroundColor(.customLightGray)
                            .padding(.top, 2)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    Splash()
}

