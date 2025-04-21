//
//  Navigation.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI



struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, vets, lostPet, updates, profile
    }

    var body: some View {
        ZStack {
            VStack {
                Spacer()
//                Text("Selected: \(selectedTabLabel(for: selectedTab))")
//                    .foregroundColor(.white)
//                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.black.ignoresSafeArea())
    }

    func selectedTabLabel(for tab: Tab) -> String {
        switch tab {
        case .home: return "Home"
        case .vets: return "Vets"
        case .lostPet: return "Lost Pet"
        case .updates: return "Updates"
        case .profile: return "Profile"
        }
    }
}

// MARK: - Custom Tab Bar

struct CustomTabBar: View {
    @Binding var selectedTab: MainTabView.Tab

    var body: some View {
        ZStack {
            HStack {
                TabBarButton(image: "house", title: "Home", tab: .home, selectedTab: $selectedTab)
                Spacer().frame(width: 50)
                TabBarButton(image: "heart", title: "Vets", tab: .vets, selectedTab: $selectedTab)
                
                Spacer().frame() // Space for center button
                
                TabBarButton(image: "clock", title: "Updates", tab: .updates, selectedTab: $selectedTab)
                Spacer().frame(width: 30)
                TabBarButton(image: "person", title: "Profile", tab: .profile, selectedTab: $selectedTab)
            }
            .padding()
            .background(Color.black.ignoresSafeArea(edges: .bottom))

            Button(action: {
                selectedTab = .lostPet
            }) {
                ZStack {
                    Circle()
                        .fill(Color.customLightGray)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.white.opacity(0.2), radius: 6, x: 0, y: 4)

                    Text("Lost Pet")
                        .font(.system(size: 13, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
            }
            .offset(y: -30)
        }
    }
}

// MARK: - Tab Bar Button

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



#Preview {
    MainTabView()
}
