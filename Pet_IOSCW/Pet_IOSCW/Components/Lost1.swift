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
                .padding(.top, 50)
                
                
                Spacer()
                    
              
            }.padding()
            
            HStack{
                Text("Add Pet Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(.customLightGray)
                    .padding(.top, 20)
                Spacer()
            }
                
            
           
            
            Button(action: {
                
            }) {
                Image (systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.customLightGray)
                    .padding(.top, 50)
                
                
                
                
            }
            Text("add photos")
            
            TextField("Enter Pet Name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 50)
                .padding(.bottom, 50)
            
            TextField("Start typing", text: $description)
//                .frame(height:150)
                .textFieldStyle(RoundedBorderTextFieldStyle())
//
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.customLightGray))
            
            Spacer()
            VStack{
              
                Button ("Next >"){
                    
                }
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
