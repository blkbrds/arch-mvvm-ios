//
//  UserProvider.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import RealmS
import MVVM

class UserProvider: MVVM.Provider {
    typealias T = User
    typealias S = Results<User>

    private let objects = RealmS().objects(User.self)

    var count: Int { return objects.count }

    func object(at index: Int) -> User {
        return objects[index]
    }

    // Services
    func fetch(_ completion: @escaping () -> Void) -> Self {
        return self
    }

    func update(_ completion: @escaping () -> Void) -> Self {
        return self
    }
}
