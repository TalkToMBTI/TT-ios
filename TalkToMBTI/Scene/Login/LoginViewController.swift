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
  
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    setupUI()
    viewModel?.checkCurrentUserState()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel?.socialSignInWithWebUI(type: .apple, view: self.view.window!)
    viewModel?.restAPITest()
  }
  
  func setupUI() {
    view.backgroundColor = .white
  }
  
  func bind() {
    viewModel?.resultOfSocialSignIn
      .bind(onNext: { [weak self] result in
        if result {
        }
      })
      .disposed(by: disposeBag)
  }
}

