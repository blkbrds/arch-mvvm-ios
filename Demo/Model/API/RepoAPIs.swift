//
//  RepoAPIs.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias RepoCompletion = (Result<[Repo]>) -> Void
extension API.Repo {
    static func getAll(completion: @escaping RepoCompletion) {
        api.request(method: .get, urlString: ApiPath.User.allRepo) { (result) in
            switch result {
            case .success(let json):
                
                if let jsons = json["data"] as? [[String: Any]],
                    let repos: [Repo] = Mapper<Repo>().mapArray(JSONArray: jsons) {
                    completion(Result.success(repos))
                } else {
                    completion(Result.failure(API.Error.json))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
