//
//  Lost5.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI

struct Lost5 : View {
    @State private var contactNumber = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            
            Text("Enter Your Contact Number")
                .font(.title2)
                .foregroundColor(.white)
            
            HStack{
                Text("+94")
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                TextField("Enter number", text: $contactNumber)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.numberPad)
                    .foregroundColor(.white)
                
            }
            Spacer()
            
            Button("Post"){}
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color.customLightGray)
                .cornerRadius(10)
            
            
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}



#Preview {
    Lost5()
}
