//
//  Provider.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public protocol Provider: class {
    associatedtype T

    var count: Int { get }
    func object(at index: Int) -> T

    // Services
    func fetch(_ completion: @escaping () -> Void) -> Self
    func update(_ completion: @escaping () -> Void) -> Self
}
