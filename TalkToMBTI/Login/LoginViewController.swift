//
//  LoginViewController.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import UIKit
import RxSwift
import Amplify
import AmplifyPlugins

class LoginViewController: UIViewController {
  
  let viewModel: LoginViewModel = LoginViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    socialSignInWithWebUI()
  }
  
  func setupUI() {
    view.backgroundColor = .white
  }

  func socialSignInWithWebUI() {
      Amplify.Auth.signInWithWebUI(for: .apple, presentationAnchor: self.view.window!) { result in
          switch result {
          case .success:
              print("Sign in succeeded")
          case .failure(let error):
              print("Sign in failed \(error)")
          }
      }
  }
}

