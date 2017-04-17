//
//  String.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension String {
    var len: Int { return characters.count }
    var host: String? { return (try? asURL())?.host }

    enum EncodingMethod {
        case encode
        case decode
    }

    func base64(_ method: EncodingMethod) -> String? {
        switch method {
        case .encode:
            guard let data = data(using: .utf8) else { return nil }
            return data.base64EncodedString()
        case .decode:
            guard let data = Data(base64Encoded: self) else { return nil }
            return String(data: data, encoding: .utf8)
        }
    }
}
