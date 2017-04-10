//
//  Dictionary.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func updateValues(_ info: [Key: Value]?) {
        guard let info = info else { return }
        for (key, value) in info {
            self[key] = value
        }
    }
}
