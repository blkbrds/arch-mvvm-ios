//
//  LoginViewModel.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class LoginViewModel: MVVM.ViewModel {
    enum Validation: CustomStringConvertible {
        case success
        case failure(key: String, msg: String)

        var passed: Bool {
            switch self {
            case .success: return true
            default: return false
            }
        }

        var description: String {
            switch self {
            case .success: return "Success"
            case .failure(_, let msg):
                return "Failure: " + msg
            }
        }
    }

    var name = ""
    var pass = ""

    init(user: User?) {
        guard let user = user else { return }
        name = user.name
    }

    func validate() -> Validation {
        guard name.len >= 6 else {
            return .failure(key: "name", msg: "'name' too short")
        }
        guard pass.len >= 6 else { return .failure(key: "pass", msg: "'pass' too short") }
        return .success
    }

    enum LoginResult {
        case success
        case failure(error: Error)
    }

    func login(_ completion: @escaping (LoginResult) -> Void) {
        let validation = validate()
        guard validation.passed else {
            let info: [String: Any] = [
                NSLocalizedDescriptionKey: validation.description
            ]
            let error = NSError(domain: "", code: -1, userInfo: info)
            completion(.failure(error: error))
            return
        }
        let ws = API.User(id: 0)
        let params = API.User.LoginParams(name: name, pass: pass)
        ws.login(params: params) { (result) in
            switch result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}

extension String {
    var len: Int { return characters.count }
}
