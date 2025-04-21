//
//  Spot2.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI

struct Spot2: View {
    @State private var message = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Tap to Contact Owner")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                Spacer()
                Image(systemName: "phone.fill")
                    .foregroundColor(.white)
            }

            Text("Send A Message To The Owner")
                .foregroundColor(.white)
                .font(.headline)

            TextEditor(text: $message)
                .frame(height: 150)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.white)

            HStack {
                Image(systemName: "mappin")
                Text("Colombo")
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .foregroundColor(.white)

            Spacer()

            Button("Post") {
                
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.customLightGray)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    Spot2()
}
