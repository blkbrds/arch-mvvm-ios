//
//  Presenter.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

public protocol View: class {
    associatedtype T: ViewModel
    var viewModel: T { set get }
}
