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

final class Repo: Object, StaticMappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var desc: String?

    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return RealmS().object(ofType: self, forMapping: map)
    }
}
