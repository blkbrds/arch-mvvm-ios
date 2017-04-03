//
//  UserVM.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class UserViewModel: MVVM.ViewModel {
    typealias T = User
    var model: User?
    var origin: T?
    var delegate: UserProvider?

    enum Validation {
        case success
        case failure(key: String, msg: String)
    }

    var mail = ""
    var pass = ""

    init(model: User?) {
        guard let model = model else { return }
        mail = model.mail
    }

    func validate() -> Validation {
        let comps = mail.components(separatedBy: "@")
        guard comps.count == 2,
            let name = comps.first, name.len >= 6,
            let domain = comps.last, domain.len >= 5
        else {
            return .failure(key: "mail", msg: "'mail' too short")
        }
        guard pass.len >= 6 else { return .failure(key: "pass", msg: "'pass' too short") }
        return .success
    }

    enum LoginResult {
        case success
        case failure(code: Int)
    }

    func login(_ completion: @escaping (LoginResult)->Void) {
        let ws = UserServices(userId: 0)
        ws.login { (_) in
            completion(.success)
        }
    }
}

extension String {
    var len: Int { return characters.count }
}
