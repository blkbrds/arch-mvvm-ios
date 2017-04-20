//
//  ResponseSerializer.swift
//  CM
//
//  Created by DaoNV on 3/7/16.
//  Copyright © 2016 AsianTech Inc. All rights reserved.
//

import Alamofire
import RealmSwift
import ObjectMapper
import RealmS
import SwiftyJSON

extension Request {
    static func responseJSONSerializer(log: Bool = true,
                                       response: HTTPURLResponse?,
                                       data: Data?,
                                       error: Error?) -> Result<JSObject> {
        guard let response = response else {
            return .failure(NSError(status: .requestTimeout))
        }

        if let error = error {
            return .failure(error)
        }

        let statusCode = response.statusCode

        if 204...205 ~= statusCode { // empty data status code
            return .success([:])
        }

        guard 200...299 ~= statusCode else {
            var err: NSError!
            if let json = data?.toJSON() as? JSObject, let errors = json["errors"] as? JSArray, !errors.isEmpty, let message = errors[0]["value"] as? String {
                err = NSError(message: message)
            } else if let status = HTTPStatus(code: statusCode) {
                err = NSError(domain: Api.Path.baseURL.host, status: status)
            } else {
                err = NSError(domain: Api.Path.baseURL.host,
                              code: statusCode,
                              message: "Unknown HTTP status code received (\(statusCode)).")
            }

            return .failure(err)
        }

        guard let data = data, let json = data.toJSON() else {
            return Result.failure(Api.Error.json)
        }

//        if let token = Session.Token(headers: response.allHeaderFields) {
//            api.session.token = token
//        }
        if let js = json as? JSObject {
            return .success(js)
        }
        return .success(["data": json])
    }
}

extension DataRequest {
    static func responseSerializer() -> DataResponseSerializer<JSObject> {
        return DataResponseSerializer { _, response, data, error in
            return Request.responseJSONSerializer(log: true, response: response, data: data, error: error)
        }
    }

    @discardableResult
    func responseJSON(queue: DispatchQueue? = nil, completion: @escaping (DataResponse<JSObject>) -> Void) -> Self {
        return response(responseSerializer: DataRequest.responseSerializer(), completionHandler: completion)
    }
}
