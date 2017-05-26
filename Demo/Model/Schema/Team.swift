//
//  Team.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/26/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RealmS

final class Team: Object, StaticMappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var slug = ""
    dynamic var desc: String?
    dynamic var memberCount = 0
    dynamic var repoCount = 0
    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        name <- map["name"]
        slug <- map["slug"]
        desc <- map["description"]
        memberCount <- map["members_count"]
        repoCount <- map["repos_count"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return RealmS().object(ofType: self, forMapping: map)
    }
}
