//
//  AppDelegate.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import UIKit
import Amplify
import AmplifyPlugins

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.configure()
        print("Amplify configured with auth plugin")
    } catch {
        print("Failed to initialize Amplify with \(error)")
    }
    
    fetchCurrentAuthSession()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.rootViewController = LoginViewController()
    window?.makeKeyAndVisible()
    return true
  }
  
  func fetchCurrentAuthSession() {
      _ = Amplify.Auth.fetchAuthSession { result in
          switch result {
          case .success(let session):
              print("Is user signed in - \(session.isSignedIn)")
          case .failure(let error):
              print("Fetch session failed with error \(error)")
          }
      }
  }
}

