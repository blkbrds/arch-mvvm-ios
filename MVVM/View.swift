//
//  Presenter.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

/**
 OS X and iOS both have view (or window) controllers, which may be confusing at first glance, since MVVM only refers to
 a view.

 But upon closer inspection, it becomes apparent that view controllers are *actually just part of the view layer*, since
 they handle things like:

 - Layout
 - Animations
 - Device rotation
 - View and window transitions
 - Presenting loaded UI

 So, "the view" actually means the view *layer*, which includes view controllers. There's no need to have a view and a 
 view controller for the same section of the screen, though — just pick whichever class is easier for the use case.

 No matter whether you decide to use a view or a view controller, you'll still have a view model.
 */
@objc public protocol View: class {
    @objc optional var viewModel: ViewModel { set get }
    @objc optional func updateView()
}

extension View {
    public func viewDidUpdated() {
        let nc = NotificationCenter.default
        nc.post(name: .viewDidUpdated, object: self)
    }
}

extension NSNotification.Name {
    public static let viewDidUpdated = NSNotification.Name("viewDidUpdated")
}
