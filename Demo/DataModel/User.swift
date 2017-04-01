//
//  User.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
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
        //
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        guard let key = primaryKey() else { return nil }
        var id = 0
        id <- map[key]
        guard id > 0 else { return nil }
        return RealmS().object(ofType: self, forPrimaryKey: id)
    }
}
