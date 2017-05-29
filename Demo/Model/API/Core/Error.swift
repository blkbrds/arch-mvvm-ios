//
//  Error.swift
//  CM
//
//  Created by DaoNV on 3/7/16.
//  Copyright © 2016 AsianTech Inc. All rights reserved.
//

import Foundation
import Alamofire

typealias Network = NetworkReachabilityManager

// MARK: - Network
extension Network {
    static let shared: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

extension Api {
    struct Error {
        static let network = NSError(domain: NSCocoaErrorDomain, message: "The internet connection appears to be offline.")
        static let authen = NSError(domain: Api.Path.baseURL.host, status: HTTPStatus.unauthorized)
        static let json = NSError(domain: NSCocoaErrorDomain, code: 3_840, message: "The operation couldn’t be completed.")
        static let apiKey = NSError(domain: Api.Path.baseURL.host, status: HTTPStatus.badRequest)
    }
}

extension Error {
    func show() {
        let `self` = self as NSError
        self.show()
    }

    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}

extension NSError {
    func show() { }
}
