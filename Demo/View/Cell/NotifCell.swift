//
//  NotifCell.swift
//  Demo
//
//  Created by DaoNV on 5/22/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class NotifCell: UITableViewCell, MVVM.View {
    var viewModel: NotifCellViewModel? {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            // clean
            return
        }
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.desc
    }
}
