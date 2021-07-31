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
  static let prod = APIEnvironment(baseUrl: URL(string: "https://bdzty6xjs4.execute-api.ap-northeast-2.amazonaws.com/dev")!)
}
