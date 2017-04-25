//
//  Utils.swift
//  Demo
//
//  Created by DaoNV on 4/25/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire

struct Timeout {
    static var forRequest: TimeInterval {
        return Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest
    }

    static var forResource: TimeInterval {
        return Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource
    }
}
