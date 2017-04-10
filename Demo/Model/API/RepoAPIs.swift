//
//  RepoAPIs.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension API.User {
    static func getAll(completion: @escaping Completion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let json = JSON()
            completion(.success(json))
        }
    }
}
