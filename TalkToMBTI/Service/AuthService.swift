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
  func socialSignInWithWebUI(type: AuthProvider, view: UIWindow) -> Single<Void>
  func signOutGlobally()
  func checkCurrentUserStateInAWS()
  //    func saveUserFromRealm(user: User) -> Observable<User>
}

final class AuthService: BaseService, AuthServiceType {
  
  let repository = APIRepository.shared
  
  func socialSignInWithWebUI(type: AuthProvider, view: UIWindow) -> Single<Void> {
    return Single<Void>.create { observer in
      Amplify.Auth.signInWithWebUI(for: type, presentationAnchor: view) { result in
          switch result {
          case .success:
              print("Sign in succeeded")
            observer(.success(()))
          case .failure(let error):
              print("Sign in failed \(error)")
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
  
  func checkCurrentUserStateInAWS() {
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
