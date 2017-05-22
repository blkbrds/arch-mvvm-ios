//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

@objc public protocol ViewModel: class { }

// MARK: - Object

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

// MARK: - Collection

public enum CollectionChanges {
    case initial
    case update(deletions: [Int], insertions: [Int], modifications: [Int])
    case error(Error)
}

public protocol CollectionViewModelDelegate: class {
    func viewModel(change changes: CollectionChanges)
}

public protocol CollectionViewModel: ViewModel {
    weak var delegate: CollectionViewModelDelegate? { set get }
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func viewModelForItem<ViewModel>(at indexPath: IndexPath) -> ViewModel
}
