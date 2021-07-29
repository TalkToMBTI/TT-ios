//
//  APIRepository.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation
import RxAlamofire
import AWSAPIGateway
import AWSMobileClient

class APIRepository {
  
  static let shared = APIRepository(environment: .prod)
  
  let environment: APIEnvironment
  let client = MBTIRESTTtmbtirestClient.default()
  
  private init(environment: APIEnvironment = .prod) {
    self.environment = environment
  }
  
  func putMBTIUser() {
    client.mbtiUserPut().continueWith { result -> AnyObject? in
      if let error = result.error {
        print("Error: ", error)
      }
      
      if let result = result.result {
        print("Success")
      }
      
      return nil
    }
  }
}
