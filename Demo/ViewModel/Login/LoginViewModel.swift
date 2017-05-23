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
    enum Field: String {
        case username
        case accessToken
    }

    enum Validation: CustomStringConvertible {
        case success
        case failure(field: Field, msg: String)

        var isSuccess: Bool {
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

    var username = ""
    var accessToken = ""

    init(user: User?) {
        guard let user = user else { return }
        username = user.username
    }

    func validate() -> Validation {
        guard username.len >= 6 else {
            return .failure(field: .username, msg: "'\(Field.username)' too short")
        }
        guard accessToken.len >= 6 else { return .failure(field: .accessToken, msg: "'\(Field.accessToken)' too short") }
        return .success
    }

    enum LoginResult {
        case success
        case failure(Error)
    }

    func login(_ completion: @escaping (LoginResult) -> Void) {
        let validation = validate()
        guard validation.isSuccess else {
            let info: [String: Any] = [
                NSLocalizedDescriptionKey: validation.description
            ]
            let error = NSError(domain: "", code: -1, userInfo: info)
            completion(.failure(error))
            return
        }
        let params = Api.Me.LoginParams(username: username, token: accessToken)
        Api.Me.login(params: params) { (result) in
            switch result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
