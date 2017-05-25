//
//  NotifRepoCellViewModel.swift
//  Demo
//
//  Created by DaoNV on 5/22/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class NotifRepoCellViewModel: MVVM.ViewModel {
    var name = ""
    var desc: String?
    var repoFullName: String?

    init(notif: Notif?) {
        guard let notif = notif else { return }
        name = notif.name
        desc = notif.desc
        repoFullName = notif.repo?.fullName
    }
}
