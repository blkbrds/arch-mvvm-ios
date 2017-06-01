//
//  Utils.swift
//  Demo
//
//  Created by DaoNV on 4/25/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import MVVM
import RealmSwift
import ObjectMapper
import RealmS

@testable import Demo

struct Timeout {
    static var forRequest: TimeInterval {
        return Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest
    }

    static var forResource: TimeInterval {
        return Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource
    }
}

extension LoginViewModel {
    static var standard: LoginViewModel {
        let user = LoginViewModel(user: nil)
        user.username = "at-ios-mvvm"
        user.accessToken = "101a6476440c30431a17" + "25c310d1abe049189b2a"
        return user
    }
}

extension TeamViewModel {
    static var test: TeamViewModel {
        let teamId = 1
        let realm = RealmS()
        realm.write {
            let team = Team()
            team.id = teamId
            team.name = "Team name"
            team.slug = "This my slug"
            team.desc = "This your first team"
            team.memberCount = 20
            team.repoCount = 10
        }
        let vm = TeamViewModel(teamId: teamId)
        return vm
    }
}
