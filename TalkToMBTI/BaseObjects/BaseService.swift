//
//  BaseService.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/28.
//

import Foundation

class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
