//
//  Notif.swift
//  Demo
//
//  Created by DaoNV on 5/22/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RealmS

final class Notif: Object, StaticMappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var desc: String?
    dynamic var repo: Repo?
    dynamic var isUnread = true

    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
        repo <- map["repository"]
        isUnread <- map["unread"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return RealmS().object(ofType: self, forMapping: map)
    }
}
