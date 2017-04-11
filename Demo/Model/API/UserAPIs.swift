//
//  UserAPIs.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

extension API.User {
    
    struct LoginParams {
        let mail: String
        let pass: String
    }

    func login(params: LoginParams, completion: @escaping Completion) {
        var headers: [String: String] = [:]
        if let base64Encode = "\(params.mail):\(params.pass)".base64Encode {
            if !base64Encode.isEmpty {
                headers["Authorization"] = "Basic \(base64Encode)"
            }
        }
        
        let _ = APIManager.request(method: HTTPMethod.get, urlString: ApiPath.Users, parameters: nil, headers: headers) { (result) in
            completion(result)
        }
    }
}
