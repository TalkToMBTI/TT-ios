//
//  LoginCoordinator.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/31.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginCoordinatorType: Coordinator {
  
}

class LoginCoordinator: LoginCoordinatorType {
  weak var viewController: UIViewController?
  
  init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
  func pushToSetMyMBTIVC() {
    let setMyMBTIVC = SetMyMBTIViewController()
    setMyMBTIVC.viewModel = SetMyMBTIViewModel(provider: ServiceProvider())
    setMyMBTIVC.coordinator = SetMyMBTICoordinator(viewController: setMyMBTIVC)
    
    if let naviVC = viewController?.navigationController {
      naviVC.pushViewController(setMyMBTIVC, animated: true)
    } else {
      setMyMBTIVC.modalPresentationStyle = .fullScreen
      viewController?.present(setMyMBTIVC, animated: true, completion: nil)
    }
  }
}
