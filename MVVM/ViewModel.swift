//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public protocol Changes {}

public struct PropertyChange {
    public let name: String
    public let oldValue: Any?
    public let newValue: Any?
}

public enum ObjectChanges: Changes {
    case error(_: Error)
    case change(_: [PropertyChange])
    case deleted
}

public enum CollectionChanges: Changes {
    case initial
    case update(deletions: [Int], insertions: [Int], modifications: [Int])
    case error(Error)
}

public protocol ViewModel: class {
    associatedtype ModelChanges: Changes
    typealias Callback = (ModelChanges)->Void
    var changesHandler: Callback? { set get }
}

public protocol Provider: ViewModel {
    associatedtype Item: ViewModel
    var numberOfSections: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func itemForRow(at indexPath: IndexPath) -> Item
}

extension ViewModel {
    public func onChanges(_ block: Callback?) {
        changesHandler = block
    }
}
