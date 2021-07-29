//
//  LoginViewModel.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation
import RxSwift
import Amplify
import AmplifyPlugins

protocol LoginViewModelType: AnyObject {
  var provider: ServiceProviderType { get }
  var resultOfSocialSignIn: PublishSubject<Bool> { get }
  var resultFetchAuthSession: PublishSubject<Bool> { get }
  
  func socialSignInWithWebUI(type: AuthProvider, view: UIWindow)
  func signOutGlobally()
  func checkCurrentUserState()
  
  func restAPITest()
}

class LoginViewModel: LoginViewModelType {
  var model: LoginModel = LoginModel()
  let provider: ServiceProviderType
  
  var disposeBag = DisposeBag()
  
  let resultOfSocialSignIn = PublishSubject<Bool>()
  let resultFetchAuthSession = PublishSubject<Bool>()
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
  
  func socialSignInWithWebUI(type: AuthProvider, view: UIWindow) {
    provider.authService.socialSignInWithWebUI(type: type, view: view)
      .subscribe { [weak self] _ in
        self?.resultOfSocialSignIn.onNext(true)
      } onFailure: { [weak self] error in
        self?.resultOfSocialSignIn.onNext(false)
      }
      .disposed(by: disposeBag)
  }
  
  func signOutGlobally() {
    provider.authService.signOutGlobally()
  }
  
  func checkCurrentUserState() {
    provider.authService.checkCurrentUserStateInAWS() { result in
      switch result {
      case .success(let isSignedIn):
        self.resultFetchAuthSession.onNext(isSignedIn)
      case .failure(let error):
        self.resultFetchAuthSession.onError(error)
      }
    }
  }
  
  func restAPITest() {
    provider.mbtiService.restAPITest()
  }
}
