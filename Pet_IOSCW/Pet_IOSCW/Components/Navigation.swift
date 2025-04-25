//
//  Navigation.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var isAuthenticated = false

    enum Tab {
        case home, vets, lostPet, updates, profile
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
               
                Group {
                    if selectedTab == .lostPet && isAuthenticated {
                        Lost1()
                    } else {
                        switch selectedTab {
                        case .home:
                            Home()
                        case .vets:
                            Vets()
                        case .lostPet:
                            Lost1()
                            
                            Color.black
                        case .updates:
                            Text("Updates View")
                        case .profile:
                            Text("Profile View")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

              
                if !(selectedTab == .lostPet && isAuthenticated) {
                    CustomTabBar(selectedTab: $selectedTab, isAuthenticated: $isAuthenticated)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.black.ignoresSafeArea())
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: MainTabView.Tab
    @Binding var isAuthenticated: Bool

    var body: some View {
        ZStack {
            HStack {
                TabBarButton(image: "house", title: "Home", tab: .home, selectedTab: $selectedTab)
                Spacer().frame(width: 50)
                TabBarButton(image: "heart", title: "Vets", tab: .vets, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(image: "clock", title: "Updates", tab: .updates, selectedTab: $selectedTab)
                Spacer().frame(width: 30)
                TabBarButton(image: "person", title: "Profile", tab: .profile, selectedTab: $selectedTab)
            }
            .padding()
            .background(Color.black.ignoresSafeArea(edges: .bottom))

            
            Button(action: {
               
                isAuthenticated = true
                selectedTab = .lostPet
            }) {
                ZStack {
                    Circle()
                        .fill(Color.customLightGray)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    Circle()
                        .fill(Color.black)
                        .frame(width: 70, height: 70)

                    Text("Lost Pet")
                        .font(.system(size: 13, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.customLightGray)
                }
            }
            .offset(y: -30)
        }
    }
}


struct TabBarButton: View {
    let image: String
    let title: String
    let tab: MainTabView.Tab
    @Binding var selectedTab: MainTabView.Tab

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(selectedTab == tab ? .white : .gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedTab == tab ? .white : .gray)
            }
        }
    }
}



    var body: some View {
        Text("Spot2 View Content")
            .foregroundColor(.white)
            .background(Color.black)
            .navigationBarHidden(true) 
    }

