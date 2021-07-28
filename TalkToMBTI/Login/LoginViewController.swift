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
  
  // MARK: - UI properties
  
  lazy var signInWithAppleBtn = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel?.socialSignInWithWebUI(type: .apple)
  }
  
  func setupUI() {
    view.backgroundColor = .white
  }
  
  func bind() {
    viewModel?.resultOfSocialSignIn
      .filter { $0 }
  }
}
