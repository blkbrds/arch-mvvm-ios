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

    var count: Int { return objects.count }

    var onChangesHandler: (() -> Void)?

    func object(at index: Int) -> User {
        return objects[index]
    }

    private let objects = RealmS().objects(User.self)
}
