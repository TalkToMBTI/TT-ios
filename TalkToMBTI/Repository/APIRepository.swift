//
//  APIRepository.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation
import RxAlamofire
import Amplify
import AmplifyPlugins
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
//    client.mbtiUserPut().continueWith { result -> AnyObject? in
//      if let error = result.error {
//        print("Error: ", error)
//      }
//
//      if let result = result.result {
//        print("Success")
//        print("-> End API Test")
//      }
//
//      return nil
//    }
    let headerParameters = [
                 "Content-Type": "application/json",
                 "Accept": "application/json",

            ]

    let queryParameters:[String:String] = [:]

    let request = RESTRequest(path: "/mbti/user", headers: headerParameters, queryParameters: queryParameters, body: nil)

    Amplify.API.put(request: request) { result in
      switch result {
      case .success:
          print("Success")
          print("-> End API Test")
      case .failure(let apiError):
          print("Failed", apiError)
          print("-> End API Test")
      }
    }
  }
}
