//
//  Lost1.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI

struct Lost1 :View {
    @State private var petName = ""
    @State private var description = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(" < Back"){}
                .foregroundColor(.customLightGray)
                
                Spacer()
            }.padding()
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image (systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.customLightGray)
                
                
            }
            
            TextField("Enter Pet Name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextEditor(text: $description)
                .frame(height:150)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.customLightGray))
            
            Spacer()
            
            Button ("Next >"){
                
            }
            .padding()
            .foregroundColor(.customLightGray)
            
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

#Preview {
    Lost1()
}
