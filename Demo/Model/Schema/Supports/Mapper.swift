//
//  Mapper.swift
//  MVVM
//
//  Created by DaoNV on 3/17/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import ObjectMapper
import RealmS

extension RealmS {
    func object<T: Object>(ofType: T.Type, forMapping map: Map) -> T? {
        guard let key = T.primaryKey() else { return nil }
        var id: Any?
        id <- map[key]
        guard let value = id else { return nil }
        return object(ofType: T.self, forPrimaryKey: value)
    }
}

extension Mapper where N: Object, N: Mappable {
    func map(result: Result<Any>, type: DataType, completion: Completion) {
        switch result {
        case .success(let json):
            switch type {
            case .object:
                guard let obj = json as? JSObject else {
                    completion(.failure(Api.Error.json))
                    return
                }
                let realm = RealmS()
                realm.write {
                    realm.map(N.self, json: obj)
                }
                completion(.success(json))
            case .array:
                guard let objs = json as? JSArray else {
                    completion(.failure(Api.Error.json))
                    return
                }
                let realm = RealmS()
                realm.write {
                    realm.map(N.self, json: objs)
                }
                completion(.success(json))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

enum DataType {
    case object
    case array
}
