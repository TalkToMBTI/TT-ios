//
//  LoginViewModel.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation
import RxSwift

protocol LoginViewModelType: AnyObject {
  var provider: ServiceProviderType { get }
  var resultOfSocialSignIn: PublishSubject<Bool> { get }
  
  func socialSignInWithWebUI(type: SocialLoginType)
  func signOutGlobally()
}

class LoginViewModel: LoginViewModelType {
  var model: LoginModel = LoginModel()
  let provider: ServiceProviderType
  
  var disposeBag = DisposeBag()
  
  let resultOfSocialSignIn = PublishSubject<Bool>()
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
  
  func socialSignInWithWebUI(type: SocialLoginType) {
    provider.authService.socialSignInWithWebUI(type: type)
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
}
