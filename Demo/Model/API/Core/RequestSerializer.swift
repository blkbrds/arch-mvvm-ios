//
//  RequestSerializer.swift
//  CM
//
//  Created by DaoNV on 7/8/16.
//  Copyright © 2016 AsianTech Co., Ltd. All rights reserved.
//

import Alamofire
import Foundation

extension ApiManager {
    static func request(method: HTTPMethod,
                       urlString: String,
                       parameters: [String: Any]? = nil,
                       headers: [String: String]? = nil,
                       completion: Completion?) -> Request? {
        guard Network.shared.isReachable else {
            completion?(.failure(RSError.network))
            return nil
        }

        logger.info("\n url -> \(urlString)")
        if let headers = headers {
            logger.info("\n headers -> \(headers)")
        }

        if let params = parameters {
            logger.info("\n parameters -> \(params)\n")
        }

        let encoding: ParameterEncoding = (method == .post) ? JSONEncoding.default : URLEncoding.default

        var _headers = api.defaultHTTPHeaders
        _headers.updateValues(headers)

        let request = Alamofire.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: _headers)
        _ = request.responseJSON(completion: { (response) in
            completion?(response.result)
        })
        return request
    }
}
