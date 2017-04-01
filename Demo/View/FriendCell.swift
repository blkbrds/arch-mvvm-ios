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
    final class ViewModel: MVVM.ViewModel {
        typealias T = User
        var model: User?

        var name = "" { didSet { propertyDidChanged () } }
        var mail = "" { didSet { propertyDidChanged () } }

        weak var delegate: MVVM.Presenter?

        init(model: User?) {
            guard let model = model else { return }
            name = model.name
            mail = model.mail
        }

        func propertyDidChanged() {
            guard let delegate = delegate else { return }
            delegate.updateView()
        }
    }

    var model = ViewModel(model: nil) {
        didSet {
            updateView()
        }
    }
}

extension FriendCell: Presenter {
    func updateView() {
        //
    }

    var identifier: String { return "FriendCell" }
}
