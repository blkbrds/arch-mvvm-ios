//
//  RequestSerializer.swift
//  CM
//
//  Created by DaoNV on 7/8/16.
//  Copyright © 2016 AsianTech Co., Ltd. All rights reserved.
//

import Alamofire
import Foundation

extension APIManager {
    static func request(method: HTTPMethod,
                       urlString: String,
                       parameters: [String: Any]? = nil,
                       headers: [String: String]? = nil,
                       completion: Completion?) -> Request? {
        guard Network.shared.isReachable else {
            completion?(.failure(API.Error.network))
            return nil
        }

        let encoding: ParameterEncoding = (method == .post) ? JSONEncoding.default : URLEncoding.default

        var fullHeaders = api.defaultHTTPHeaders
        fullHeaders.updateValues(headers)

        let request = Alamofire.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: fullHeaders)
        _ = request.responseJSON(completion: { (response) in
            completion?(response.result)
        })
        return request
    }
}
