//
//  AuthService.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import RxSwift
import Amplify
import AmplifyPlugins
import AWSMobileClient

enum SocialLoginType {
  case facebook
  case apple
}

protocol AuthServiceType: class {
  func socialSignInWithWebUI(type: SocialLoginType) -> Single<Void>
  func signOutGlobally()
  func checkCurrentUserStateInAWS()
  //    func saveUserFromRealm(user: User) -> Observable<User>
}

final class AuthService: BaseService, AuthServiceType {
  
  func socialSignInWithWebUI(type: SocialLoginType) -> Single<Void> {
    return Single<Void>.create { observer in
      
      Amplify.Auth.signOut(options: .init(globalSignOut: true)) { result in
          switch result {
          case .success:
              print("Successfully signed out")
            observer(.success(()))
          case .failure(let error):
              print("Sign out failed with error \(error)")
            observer(.failure(error))
          }
      }
      
      return Disposables.create()
    }
  }
  
  func signOutGlobally() {
    AWSMobileClient.default().signOut(options: SignOutOptions(signOutGlobally: true)) { (error) in
        print("Error: \(error.debugDescription)")
    }
  }
  
  func checkCurrentUserStateInAWS() {
    switch (AWSMobileClient.default().currentUserState) {
    case .signedIn:
      DispatchQueue.main.async {
        print("Logged In")
      }
    case .signedOut:
      DispatchQueue.main.async {
        print("Signed Out")
      }
    default:
      AWSMobileClient.default().signOut()
    }
  }
  //    func saveUserFromRealm(user: User) -> Observable<User> {
  //        <#code#>
  //    }
}
