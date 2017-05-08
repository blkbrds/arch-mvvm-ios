//
//  Utils.swift
//  Demo
//
//  Created by DaoNV on 4/25/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import MVVM
import RealmSwift
import ObjectMapper
import RealmS

@testable import Demo

struct Timeout {
    static var forRequest: TimeInterval {
        return Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest
    }

    static var forResource: TimeInterval {
        return Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource
    }
}

extension LoginViewModel {
    static var standard: LoginViewModel {
        let user = LoginViewModel(user: nil)
        user.username = "at-ios-mvvm"
        user.accessToken = "101a6476440c30431a17" + "25c310d1abe049189b2a"
        return user
    }
}
