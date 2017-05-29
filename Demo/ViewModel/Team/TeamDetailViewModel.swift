//
//  TeamDetailViewModel.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/29/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class TeamDetailViewModel: MVVM.ViewModel {
    var name = ""
    var slug = ""
    var desc: String?
    var memberCount = ""
    var repoCount = ""

    init(team: Team?) {
        guard let team = team else { return }
        name = team.name
        slug = team.slug
        desc = team.desc
        memberCount = "\(team.memberCount)会員"
        repoCount = "[\(team.repoCount)]"
    }
}
