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

protocol MBTIServiceType: class {
  func restAPITest()
}

final class MBTIService: BaseService, MBTIServiceType {
  
  let repository = APIRepository.shared
  
  func restAPITest() {
    repository.putMBTIUser()
  }
}
