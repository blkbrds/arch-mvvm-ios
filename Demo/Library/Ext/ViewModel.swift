//
//  CollectionChanges.swift
//  MVVM
//
//  Created by DaoNV on 4/15/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import MVVM

extension ViewModel {
    func notify<Element: Object>(change: RealmCollectionChange<Results<Element>>) {
        switch change {
        case .update(_, let deletions, let insertions, let modifications):
            if !deletions.isEmpty {
                let indexPaths = deletions.map { IndexPath(item: $0, section: 0) }
                delegate??.viewModel?(self, didChangeItemsAt: indexPaths, for: .delete)
            }
            if !insertions.isEmpty {
                let indexPaths = insertions.map { IndexPath(item: $0, section: 0) }
                delegate??.viewModel?(self, didChangeItemsAt: indexPaths, for: .insert)
            }
            if !modifications.isEmpty {
                let indexPaths = modifications.map { IndexPath(item: $0, section: 0) }
                delegate??.viewModel?(self, didChangeItemsAt: indexPaths, for: .update)
            }
        default:
            break
        }
    }
}
