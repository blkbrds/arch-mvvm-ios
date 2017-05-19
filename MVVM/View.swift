//
//  Presenter.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    public static let viewDidUpdated = NSNotification.Name("MVVM.viewDidUpdated")
}

public protocol View: class {
    associatedtype ViewModel: MVVM.ViewModel
    var viewModel: ViewModel { set get }
}

extension View {
    public func viewDidUpdated() {
        let nc = NotificationCenter.default
        nc.post(name: .viewDidUpdated, object: self)
    }
}
