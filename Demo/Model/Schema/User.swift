//
//  User.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RealmS

final class User: Object, Mappable, StaticMappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var mail = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["name"]
        mail <- map["mail"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return RealmS().object(ofType: self, forMapping: map)
    }
}
