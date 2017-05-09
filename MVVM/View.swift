//
//  Presenter.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

public let ViewDidUpdatedNotification = "MVVM.ViewDidUpdatedNotification"

public protocol View: class {
    associatedtype T: ViewModel
    var viewModel: T { set get }
}

extension View {
    public func viewDidUpdated() {
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: ViewDidUpdatedNotification), object: self)
    }
}
