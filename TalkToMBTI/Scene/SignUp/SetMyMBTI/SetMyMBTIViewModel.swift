//
//  SetMyMBTIViewModel.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import Foundation
import RxSwift
import Amplify
import AmplifyPlugins

protocol SetMyMBTIViewModelType: ViewModelType {
  var provider: ServiceProviderType { get }
}

class SetMyMBTIViewModel: SetMyMBTIViewModelType {
  var model: ModelType? = SetMyMBTIModel()
  let provider: ServiceProviderType
  
  var disposeBag = DisposeBag()
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
}
