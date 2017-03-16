//
//  UserServices.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

enum Result {
    case success(JSON)
    case failure(Error)
}

typealias Completion = (Result)->Void

class UserServices {
    let userId: Int

    init(userId: Int) {
        self.userId = userId
    }

    func login(completion: @escaping Completion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let json = JSON()
            completion(.success(json))
        }
    }
}
