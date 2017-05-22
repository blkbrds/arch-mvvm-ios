//
//  Core.swift
//  MVVM
//
//  Created by DaoNV on 4/15/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import MVVM

extension RealmCollectionChange {
    var changes: CollectionChanges {
        switch self {
        case .initial(_):
            return .initial
        case .update(_, let deletions, let insertions, let modifications):
            return .update(deletions: deletions, insertions: insertions, modifications: modifications)
        case .error(let error):
            return .error(error)
        }
    }
}
