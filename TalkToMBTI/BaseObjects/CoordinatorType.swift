//
//  CoordinatorType.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/31.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator: AnyObject {
  var viewController: UIViewController? { get }
}

//protocol SomeCoordinatorType: Coordinator {
//
//  func pushToSomeVC()
//}
//
//class SomeCoordinator: SomeCoordinatorType {
//  weak var viewController: UIViewController?
//
//  init(viewController: UIViewController) {
//    self.viewController = viewController
//  }
//
//  func pushToSomeVC() {
//    let someVC = SomeViewController()
//    someVC.viewModel = SomeViewModel(provider: ServiceProvider())
//    someVC.coordinator = SomeCoordinator(viewController: someVC)
//
//    if let naviVC = viewController?.navigationController {
//      naviVC.pushViewController(someVC, animated: true)
//    } else {
//      someVC.modalPresentationStyle = .fullScreen
//      viewController?.present(someVC, animated: true, completion: nil)
//    }
//  }
//}
