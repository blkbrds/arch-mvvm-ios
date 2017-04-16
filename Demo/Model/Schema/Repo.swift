//
//  Repo.swift
//  MVVM
//
//  Created by DaoNV on 4/4/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RealmS

final class Repo: Mappable {
    var id = 0
    var name = ""
    var slug = ""

    convenience init?(map: Map) {
        self.init()
        id <- map["id"]
        name <- map["name"]
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
    }

}
