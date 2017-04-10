//
//  Session.swift
//  CM
//
//  Created by DaoNV on 3/7/16.
//  Copyright © 2016 AsianTech Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

let kUserIDKey = "UserID"

final class Session {
    struct Token {
        let values: [String:String]

        init(values: [String:String]) {
            for key in Token.allKeys {
                guard values[key] != nil else {
                    fatalError("Invalid token value for key: `\(key)`")
                }
            }
            self.values = values
        }

        init?(pref: UserDefaults) {
            let pref = UserDefaults.standard
            var values: [String:String] = [:]
            for key in Token.allKeys {
                guard let value = pref.string(forKey: key) else { return nil }
                values[key] = value
            }
            self.init(values: values)
        }

        init?(headers: [AnyHashable:Any]) {
            let fields = JSON(headers)
            var values: [String:String] = [:]
            for key in Session.Token.allKeys {
                guard let value = fields[key].string else { return nil }
                values[key] = value
            }
            self.init(values: values)
        }

        static var allKeys: [String] {
            return ["uid", "access-token", "client"]
        }
    }

    struct Credential {
        fileprivate(set) var username: String
        fileprivate(set) var password: String

        var isValid: Bool {
            return username.isNotEmpty && password.isNotEmpty
        }
    }

    var credential = Credential(username: "", password: "") {
        didSet {
            saveCredential()
        }
    }
    
    var token: Token? {
        didSet {
            guard let token = token else {
                clearToken()
                return
            }
            saveToken(token)
        }
    }

    var userID: Int? = UserDefaults.standard.object(forKey: kUserIDKey) as? Int {
        didSet {
            let userDefaults = UserDefaults.standard
            userDefaults.set(userID, forKey: kUserIDKey)
            userDefaults.synchronize()
        }
    }
    
    var isAuthenticated: Bool {
        return token != nil
    }

    init() { }

    func loadCredential() {
        let host = ApiPath.baseURL.host
        guard let accounts = SAMKeychain.accounts(forService: host)?.last,
            let account = accounts[kSAMKeychainAccountKey] as? String
        else { return }

        guard let password = SAMKeychain.password(forService: host, account: account) else { return }
        credential.username = account
        credential.password = password
    }

    private func saveCredential() {
        guard credential.isValid else { return }
        let host = ApiPath.baseURL.host
        SAMKeychain.setPassword(credential.password, forService: host, account: credential.username)
    }

    func clearCredential() {
        credential.username = ""
        credential.password = ""
        let host = ApiPath.baseURL.host
        guard let accounts = SAMKeychain.accounts(forService: host) else { return }
        for account in accounts {
            if let account = account[kSAMKeychainAccountKey] as? String {
                SAMKeychain.deletePassword(forService: host, account: account)
            }
        }
    }

    func loadToken() {
        token = Token(pref: UserDefaults.standard)
    }

    private func saveToken(_ headerToken: Token) {
        let pref = UserDefaults.standard
        for (key, value) in headerToken.values {
            pref.set(value, forKey: key)
        }
        pref.synchronize()
    }

    private func clearToken() {
        let pref = UserDefaults.standard
        for key in Token.allKeys {
            pref.removeObject(forKey: key)
        }
        pref.synchronize()
    }

    func reset() {
        token = nil
        clearCredential()
    }
}
