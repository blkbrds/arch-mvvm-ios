//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

/**
 A view model is like an adapter for the model that makes it suitable
 for presentation. The view model is also where presentation behavior goes.
 
 For example, a view model might handle:
    - Kicking off network or database requests
    - Determining when information should be hidden or shown
    - Date and number formatting
    - Localization

 However, the view model is not responsible for actually presenting information or handling input — that's the sole 
 domain of the view layer. When the view model needs to communicate something to the view, it does so through a system
 of data binding.
 */
@objc public protocol ViewModel {
    /**
     The number of sections in the list view.
     - Returns: The number of sections in the list view.
    */
    @objc optional func numberOfSections() -> Int

    /**
     Returns the number of items (cell view models) in a specified section.
     - Parameter section: An index number that identifies a section of the list.
     - Returns: The number of items in the section.
     */
    @objc optional func numberOfItems(inSection section: Int) -> Int

    /**
     Returns the item at the specified index path.
     - Parameter indexPath: The index path locating the item in the list.
     - Returns: An object representing an item of the list.
     */
    @objc optional func viewModelForItem(at indexPath: IndexPath) -> ViewModel

    /**
     Returns the header view model associated with the specified section.
     - Parameter section: An index number that identifies a section of the list.
     - Returns: The header view associated with the section.
     */
    @objc optional func viewModelForHeader(inSection section: Int) -> ViewModel

    /**
     Returns the footer view model associated with the specified section.
     - Parameter section: An index number that identifies a section of the list.
     - Returns: The footer view associated with the section.
     */
    @objc optional func viewModelForFooter(inSection section: Int) -> ViewModel

    /**
     The object that acts as the delegate of the view model. The delegate is not retained.
     */
    @objc optional weak var delegate: ViewModelDelegate? { set get }
}

/**
 An instance of ViewModel uses methods in this protocol to notify its delegate that the view model’s fetch results have
 been changed due to an insert, delete, move, or update operations.
 */
@objc public protocol ViewModelDelegate: class {
    /**
     Notifies the receiver of the addition or removal of a section.
     - Parameters:
        - viewModel: The view model that sent the message.
        - section: The section that changed.
        - changeType: The type of change. For valid values see `ChangeType`.
     */
    @objc optional func viewModel(_ viewModel: ViewModel,
                                  didChangeSectionAt section: Int,
                                  for changeType: ChangeType)

    /**
     Notifies the receiver that a fetched object has been changed due to an insert, delete, move, or update.
     - Parameters:
       - viewModel: The view model that sent the message.
       - indexPaths: The index path of the changed object (this value is nil for insertions).
       - changeType: The type of change. For valid values see `ChangeType`.
     */
    @objc optional func viewModel(_ viewModel: ViewModel,
                                  didChangeItemsAt indexPaths: [IndexPath],
                                  for changeType: ChangeType)
}

@objc public enum ChangeType: Int {
    case insert
    case delete
    case move
    case update
}
