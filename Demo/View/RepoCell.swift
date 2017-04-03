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
    // MARK: - MVVM
    typealias T = RepoCellViewModel
    var viewModel = RepoCellViewModel(model: nil)

    func updateView(viewModel: RepoCellViewModel) {
        //
    }
    // MARK: -
}
