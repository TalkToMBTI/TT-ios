//
//  SetMyMBTICoordinator.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/31.
//

import UIKit
import RxSwift
import RxCocoa

protocol SetMyMBTICoordinatorType: Coordinator {
  
}

class SetMyMBTICoordinator: SetMyMBTICoordinatorType {
  weak var viewController: UIViewController?
  
  init(viewController: UIViewController) {
    self.viewController = viewController
  }
}
