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
    
    do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.configure()
        print("Amplify configured with auth plugin")
    } catch {
        print("Failed to initialize Amplify with \(error)")
    }

    let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.APNortheast2,
       identityPoolId:"ap-northeast-2:c88e7957-6c5f-4f58-908d-e07d0cfe9ca2")

    let configuration = AWSServiceConfiguration(region:.APNortheast2, credentialsProvider:credentialsProvider)

    AWSServiceManager.default().defaultServiceConfiguration = configuration
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    
    let loginVC = LoginViewController()
    loginVC.viewModel = LoginViewModel(provider: ServiceProvider())
    
    window?.rootViewController = loginVC
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
