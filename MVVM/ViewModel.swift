//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public protocol ViewModel: class {
    associatedtype T
    var model: T? { get }
    init(model: T?)
}
