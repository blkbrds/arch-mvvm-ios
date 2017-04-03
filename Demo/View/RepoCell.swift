//
//  RepoCell.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class RepoCell: UITableViewCell, Presenter {
    typealias T = RepoCellViewModel
    var model = RepoCellViewModel(model: nil)

    func updateView(model: RepoCellViewModel) {
        //
    }
}
