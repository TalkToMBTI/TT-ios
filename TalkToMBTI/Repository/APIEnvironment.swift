//
//  APIEnvironment.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import Foundation

struct APIEnvironment {
  var baseUrl: URL
}

extension APIEnvironment {
  static let prod = APIEnvironment(baseUrl: URL(string: "https://ltq23n7hwl.execute-api.ap-northeast-2.amazonaws.com/dev")!)
}
