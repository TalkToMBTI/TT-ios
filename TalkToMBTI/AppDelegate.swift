//
//  AppDelegate.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import UIKit
import Amplify
import AmplifyPlugins
import AWSMobileClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Initialize AWSMobileClient singleton
    AWSMobileClient.default().initialize { (userState, error) in
        if let userState = userState {
            print("UserState: \(userState.rawValue)")
        } else if let error = error {
            print("error: \(error.localizedDescription)")
        }
    }
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    
    let loginVC = LoginViewController()
    loginVC.viewModel = LoginViewModel(provider: ServiceProvider())
    
    window?.rootViewController = loginVC
    window?.makeKeyAndVisible()
    return true
  }
}

