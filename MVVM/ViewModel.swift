//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public protocol ViewModel: class { }

// MARK: ObjectViewModel

public struct PropertyChange {
    public let name: String
    public let oldValue: Any?
    public let newValue: Any?
}

public enum ObjectChanges {
    case error(_: Error)
    case change(_: [PropertyChange])
    case deleted
}

public protocol ObjectViewModelDelegate: class {
    func viewModel(change changes: ObjectChanges)
}

public protocol ObjectViewModel: ViewModel {
    weak var delegate: ObjectViewModelDelegate? { set get }
}

// MARK: CollectionViewModel

public enum CollectionChanges {
    case initial
    case update(deletions: [Int], insertions: [Int], modifications: [Int])
    case error(Error)
}

public protocol CollectionViewModelDelegate: class {
    func viewModel(change changes: CollectionChanges)
}

public protocol CollectionViewModel: ViewModel {
    associatedtype Item: ViewModel
    weak var delegate: CollectionViewModelDelegate? { set get }
    var numberOfSections: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func itemForRow(at indexPath: IndexPath) -> Item
}
