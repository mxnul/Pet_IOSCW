//
//  Spot2.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//
import SwiftUI
import UserNotifications

struct Spot2: View {
    @State private var message = ""
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
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

                ZStack {
                    if message.isEmpty {
                        TextEditor(text: .constant("Type your message here..."))
                            .foregroundColor(.black.opacity(0.5))
                            .frame(height: 150)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .disabled(true)
                    }
                    
                    TextEditor(text: $message)
                        .foregroundColor(.black)
                        .frame(height: 150)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .zIndex(1)
                }

                Spacer()

                Button("Post") {
                    handlePost()
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.customLightGray)
                .cornerRadius(10)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Message Sent"),
                        message: Text("Your message has been sent to the pet owner."),
                        dismissButton: .default(Text("OK")) {
                            message = ""
                        }
                    )
                }
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .onAppear {
                UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }

   
    func handlePost() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        sendLocalNotification(with: message)
                    }
                    DispatchQueue.main.async {
                        showAlert = true
                    }
                }
            case .authorized:
                sendLocalNotification(with: message)
                DispatchQueue.main.async {
                    showAlert = true
                }
            default:
                DispatchQueue.main.async {
                    showAlert = true
                }
            }
        }
    }

    func sendLocalNotification(with body: String) {
        let content = UNMutableNotificationContent()
        content.title = "Message to Pet Owner"
        content.body = body.isEmpty ? "No message provided." : body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🚨 Notification error: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled.")
            }
        }
    }
}


class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

#Preview {
    Spot2()
}
