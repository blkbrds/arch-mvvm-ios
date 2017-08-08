//
//  Model.swift
//  MVVM
//
//  Created by DaoNV on 4/4/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

/**
 The model in MVVM is an implementation of the application's domain model that includes a data model along with business
 and validation logic. Examples of model objects include repositories, business objects, data transfer objects (DTOs), 
 Plain Old CLR Objects (POCOs), and generated entity and proxy objects.
 */
public protocol Model {
    static func all() -> [Self]
    static func find(id: Any) -> Self?
    func save() -> Self
}

extension Model {
    static func all() -> [Self] {
        return []
    }

    static func find(id: Any) -> Self? {
        return nil
    }

    func save() -> Self {
        fatalError("Not Implement")
    }
}
