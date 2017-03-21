//
//  User.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class User {
    var id = 0
    var name = ""
    var mail = ""

    init(json: JSON) {
        id =! json["id"] as? Int
    }
}
