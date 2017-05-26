//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

// MARK: - Collection

@objc public enum ChangeType: Int {
    case insert
    case delete
    case update
    case move
}

@objc public protocol ViewModelDelegate: class {
    @objc optional func viewModel(_ viewModel: ViewModel, didChangeItemsAt indexPaths: [IndexPath], changeType: ChangeType)
}

@objc public protocol ViewModel {
    @objc optional func numberOfSections() -> Int
    @objc optional func numberOfItems(inSection section: Int) -> Int
    @objc optional func viewModelForItem(at indexPath: IndexPath) -> ViewModel
    @objc optional func viewModelForHeader(inSection section: Int) -> ViewModel
    @objc optional func viewModelForFooter(inSection section: Int) -> ViewModel
    @objc optional weak var delegate: ViewModelDelegate? { set get }
}
