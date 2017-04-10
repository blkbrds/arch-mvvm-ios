//
//  ViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public protocol ViewModel: class {
}

public protocol Provider: class {
    associatedtype Item: ViewModel
    var numberOfSections: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func itemForRow(at indexPath: IndexPath) -> Item
}
