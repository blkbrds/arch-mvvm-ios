//
//  TeamViewModel.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/26/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import RealmS
import MVVM

final class TeamViewModel: MVVM.ViewModel {
    let teamId: Int
    var teamDetailViewModel: TeamDetailViewModel? {
        let team = RealmS().object(ofType: Team.self, forPrimaryKey: teamId)
        return TeamDetailViewModel(team: team)
    }

    init(teamId: Int) {
        self.teamId = teamId
    }

    enum GetTeamResult {
        case success
        case failure(Error)
    }

    typealias GetTeamCompletion = (GetTeamResult) -> Void

    func getTeamDetail(completion: @escaping GetTeamCompletion) {
        let params = Api.Team.QueryParams(teamId: teamId)
        Api.Team.query(params: params) { (result) in
            RealmS().refresh()
            switch result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
