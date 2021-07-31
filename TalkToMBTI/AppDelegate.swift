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
      try Amplify.add(plugin: AWSAPIPlugin())
      try Amplify.configure()
      print("Amplify configured with API and Auth plugin")
    } catch {
      print("Failed to initialize Amplify with \(error)")
    }
    
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.APNortheast2,
                                                            identityPoolId:"ap-northeast-2:ff20c60a-0c8d-4fc0-8f71-6e3d6ead6245")
    
    let configuration = AWSServiceConfiguration(region:.APNortheast2, credentialsProvider:credentialsProvider)
    
    AWSServiceManager.default().defaultServiceConfiguration = configuration
    
    credentialsProvider.getIdentityId().continueWith(block: { (task) -> AnyObject? in
      if (task.error != nil) {
        print("Error: " + task.error!.localizedDescription)
      }
      else {
        // the task result will contain the identity id
        let cognitoId = task.result!
        print("Cognito id: \(cognitoId)")
      }
      return task;
    })
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    
    let loginVC = LoginViewController()
    loginVC.viewModel = LoginViewModel(provider: ServiceProvider())
    loginVC.coordinator = LoginCoordinator(viewController: loginVC)
    let loginNaviVC = UINavigationController(rootViewController: loginVC)
    loginVC.modalPresentationStyle = .fullScreen
    
    window?.rootViewController = loginNaviVC
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
