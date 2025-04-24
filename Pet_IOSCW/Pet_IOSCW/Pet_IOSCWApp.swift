//
//  Pet_IOSCWApp.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-11.
//

import SwiftUI

import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Pet_IOSCWApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabView()
            }
        }
    }
}
