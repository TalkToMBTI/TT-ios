//
//  APIRepository.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Amplify
import AmplifyPlugins
import AWSAPIGateway
import AWSMobileClient

class APIRepository {
  
  static let shared = APIRepository(environment: .prod)
  
  let environment: APIEnvironment
  let client = TTDevttmbtiClient.default()
  
  private init(environment: APIEnvironment = .prod) {
    self.environment = environment
  }
  
  func putMBTIUser() {
    AWSMobileClient.default().getTokens { tokens, err in
      if let accessToken = tokens?.accessToken?.tokenString {
        print("accessToken :", accessToken)
        self.putMBTIUser(token: accessToken)
      } else if let error = err {
        print(error)
      }
    }
  }
  
  func putMBTIUser(token: String) {
    let headerParameters = [
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization" : token
    ]
    
    let queryParameters:[String:String] = [:]
    
    let request = RESTRequest(path: "/mbti/user",
                              headers: headerParameters,
                              queryParameters: queryParameters,
                              body: nil)
    Amplify.API.get(request: request) { result in
      switch result {
      case .success:
        print("Success")
        print("-> End API Test")
      case .failure(let apiError):
        print("Failed", apiError, apiError.errorDescription, apiError.localizedDescription)
        print("-> End API Test")
      }
    }
  }
  
  func getMBTIList() -> Observable<Result<[MBTI], Error>> {
    return Observable<Result<[MBTI],Error>>.create { observer in
      let dummyMBTIList = "EINSTFPJ"
        .map { String($0) }
      var mbtiListForReturn: [MBTI] = []
      
      for i in dummyMBTIList[0...1] {
        for j in dummyMBTIList[2...3] {
          for k in dummyMBTIList[4...5] {
            for l in dummyMBTIList[6...7] {
              mbtiListForReturn.append(MBTI(name: i+j+k+l))
            }
          }
        }
      }
      observer.onNext(.success(mbtiListForReturn))
      observer.onCompleted()
      
      return Disposables.create()
    }
  }
}
