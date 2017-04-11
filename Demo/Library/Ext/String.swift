//
//  String.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension String {
    
    var host: String? {
        return (try? asURL())?.host
    }
    
    var base64Encode: String? {
        if let data  = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
}
