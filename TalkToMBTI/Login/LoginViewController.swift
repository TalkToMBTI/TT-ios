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
import AWSMobileClient

class LoginViewController: UIViewController,
                           ASAuthorizationControllerDelegate,
                           ASAuthorizationControllerPresentationContextProviding {
  

  
  
  var viewModel: LoginViewModelType?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupProviderLoginView()
    
    viewModel?.checkCurrentUserState()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  func setupUI() {
    view.backgroundColor = .white
  }
  
  func bind() {
  }
}

