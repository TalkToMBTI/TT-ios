//
//  LoginViewController.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import UIKit
import RxSwift
import RxCocoa
import Amplify
import AmplifyPlugins
import SnapKit
import Then

class LoginViewController: UIViewController {
  
  var viewModel: LoginViewModelType?
  var coordinator: LoginCoordinator?
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    viewModel?.signOutGlobally()
    viewModel?.checkCurrentUserState()
  }
  
  func setupUI() {
    view.backgroundColor = .white
  }
  
  func bind() {
    viewModel?.resultOfSocialSignIn
      .bind(onNext: { [weak self] result in
        guard let self = self else { return }
        if result {
          print("Social Login Success -> ")
          print("Result of API Test -> ")
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel?.restAPITest()
          }
        }
      })
      .disposed(by: disposeBag)
    
    viewModel?.resultFetchAuthSession
      .observe(on: MainScheduler.asyncInstance)
      .bind(onNext: { [weak self] isSignedIn in
        guard let self = self else { return }
        if isSignedIn {
          print("로그인 되어있음")
          print("Result of API Test -> ")
            self.viewModel?.restAPITest()
        } else {
          print("로그인 안되어있음")
          print("open social login web page -> ")
          self.viewModel?.socialSignInWithWebUI(type: .apple, view: self.view.window!)
        }
      })
      .disposed(by: disposeBag)
  }
}

