//
//  RepoCellViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class RepoCellViewModel: MVVM.ViewModel {
    // MARK: - MVVM
    typealias T = User
    var model: User?

    init(model: User?) {
        guard let model = model else { return }
        name = model.name
        mail = model.mail
    }
    // MARK: -

    var name = ""
    var mail = ""
}
