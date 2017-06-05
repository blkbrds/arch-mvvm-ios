//
//  TeamDetailViewModelTests.swift
//  Demo
//
//  Created by Huynh Quang Tien on 6/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS
@testable import Demo

final class TeamDetailViewModelTests: XCTestCase {
    func testTeamDetailViewModel() {
        let vm = TeamDetailViewModel.test
        XCTAssertEqual(vm.memberCount, "20 members")
        XCTAssertEqual(vm.repoCount, "[10]")
    }
}

extension TeamDetailViewModel {
    static var test: TeamDetailViewModel {
        let team = Team()
        team.name = "Team name"
        team.slug = "This my slug"
        team.desc = "This your first team"
        team.memberCount = 20
        team.repoCount = 10
        let vm = TeamDetailViewModel(team: team)
        return vm
    }
}
