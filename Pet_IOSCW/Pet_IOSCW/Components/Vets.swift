//
//  Vets.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI

struct Vets: View {
    let services = [
        ("Bathing & Drying", "scissors"),
        ("Hair Trimming", "scissors"),
        ("Nail Trimming", "scissors"),
        ("Ear Cleaning", "ear"),
        ("Teeth Brushing", "mouth"),
        ("Flea Treatment", "bandage")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("60% OFF")
                .font(.title)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)

            TextField("Search", text: .constant(""))
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.white)

            Text("Our Services")
                .foregroundColor(.white)
                .font(.headline)

            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(services, id: \.0) { service in
                    VStack {
                        Image(systemName: service.1)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        Text(service.0)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                }
            }

            Spacer()

            HStack {
                ForEach(["Home", "Vets", "Lost Pet", "Update", "Profile"], id: \.self) { tab in
                    VStack {
                        Image(systemName: "circle")
                            .foregroundColor(.white)
                        Text(tab)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    Vets()
}
