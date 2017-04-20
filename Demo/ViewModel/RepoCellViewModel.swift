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

    fileprivate(set) var repo: Repo!

    var name = ""
    var slug = ""

    init(repo: Repo) {
        name = repo.name
        slug = repo.slug
        self.repo = repo
    }
}
