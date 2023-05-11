//
//  wrer2f22App.swift
//  wrer2f22
//
//  Created by Semih Karahan on 1.05.2023.
//

import SwiftUI
import Firebase
import FirebaseCore



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

   
    return true
  }
}

class AuthViewModel: ObservableObject {
    @Published var user: User?

    init() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.user = user
            }
    }
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate



  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
