//
//  BaseViewModel.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import Foundation

protocol ViewModelType: AnyObject {
  var model: ModelType? { get }
}

//import Foundation
//import RxSwift
//import Amplify
//import AmplifyPlugins
//
//protocol SomeViewModelType: ViewModelType {
//  var provider: ServiceProviderType { get }
//}
//
//class SomeViewModel: SomeViewModelType {
//  var model: ModelType? = SomeModel()
//  let provider: ServiceProviderType
//
//  var disposeBag = DisposeBag()
//
//  init(provider: ServiceProviderType) {
//    self.provider = provider
//  }
//}
