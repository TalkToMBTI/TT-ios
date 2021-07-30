//
//  SetMyMBTIViewModel.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import Foundation
import RxSwift
import RxCocoa
import Amplify
import AmplifyPlugins

protocol SetMyMBTIViewModelType: ViewModelType {
  var provider: ServiceProviderType { get }
  var mbtiList: BehaviorRelay<[MBTI]> { get }
  
  func getMBTIList()
}

class SetMyMBTIViewModel: SetMyMBTIViewModelType {
  var model: ModelType? = SetMyMBTIModel()
  let provider: ServiceProviderType
  
  var disposeBag = DisposeBag()
  
  var mbtiList = BehaviorRelay<[MBTI]>.init(value: [])
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
  
  func getMBTIList() {
    provider.mbtiService
      .getMBTIList()
      .subscribe(onNext: { [weak self] list in
        self?.mbtiList.accept(list)
      })
      .disposed(by: disposeBag)
  }
}
