//
//  AuthService.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import RxSwift
import Amplify
import AmplifyPlugins

enum SocialLoginType {
  case facebook
  case apple
}

protocol AuthServiceType: class {
  func socialSignInWithWebUI(type: SocialLoginType) -> Single<Void>
  func signOutGlobally()
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
      Amplify.Auth.signOut(options: .init(globalSignOut: true)) { result in
          switch result {
          case .success:
              print("Successfully signed out")
          case .failure(let error):
              print("Sign out failed with error \(error)")
          }
      }
  }
  
  //    func saveUserFromRealm(user: User) -> Observable<User> {
  //        <#code#>
  //    }
}
