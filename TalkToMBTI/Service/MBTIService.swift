//
//  MBTIService.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import RxSwift
import Amplify
import AmplifyPlugins
import AWSMobileClient

protocol MBTIServiceType: AnyObject {
  func restAPITest()
  func getMBTIList() -> Observable<[MBTI]>
}

final class MBTIService: BaseService, MBTIServiceType {
  
  let repository = APIRepository.shared
  var disposeBag = DisposeBag()
  
  func restAPITest() {
    repository.putMBTIUser()
  }
  
  func getMBTIList() -> Observable<[MBTI]> {
    return Observable<[MBTI]>.create { [weak self] observer in
      guard let self = self else { return Disposables.create() }
      self.repository.getMBTIList()
        .observe(on: ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
        .subscribe(onNext: { result in
          switch result {
          case .success(let mbtiList):
            observer.onNext(mbtiList)
            observer.onCompleted()
          case .failure(let error):
            observer.onError(error)
          }
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
}
