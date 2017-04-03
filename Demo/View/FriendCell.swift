//
//  FriendCell.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class FriendCell: UITableViewCell {
    private var model = FriendCellViewModel(model: nil)

    func config(model: FriendCellViewModel) {
        self.model = model
        // udpate view
    }
}
