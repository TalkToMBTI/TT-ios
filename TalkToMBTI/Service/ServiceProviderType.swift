//
//  ServiceProviderType.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation

protocol ServiceProviderType: class {
  var authService: AuthServiceType { get }
  var mbtiService: MBTIServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
  lazy var authService: AuthServiceType = AuthService(provider: self)
  lazy var mbtiService: MBTIServiceType = MBTIService(provider: self)
}
