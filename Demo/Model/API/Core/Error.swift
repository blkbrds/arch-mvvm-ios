//
//  Error.swift
//  CM
//
//  Created by DaoNV on 3/7/16.
//  Copyright © 2016 AsianTech Inc. All rights reserved.
//

import Foundation
import Alamofire

typealias Network = NetworkReachabilityManager

// MARK: - Network
extension Network {
    static let shared: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

extension API {
    final class Error {
        static let network = NSError(domain: ApiPath.baseURL.host, status: HTTPStatus.requestTimeout, message: Strings.Error.noNetwork)
        static let authen = NSError(domain: ApiPath.baseURL.host, status: HTTPStatus.unauthorized)
        static let json = NSError(domain: NSCocoaErrorDomain, code: 3840, message: Strings.Error.json)
        static let apiKey = NSError(domain: ApiPath.baseURL.host, code: 120, message: "")
    }
}

extension Error {
    func show(level: AlertLevel = .normal) {
        let this = self as NSError
        this.show()
    }
}

extension NSError {
    func show(level: AlertLevel = .normal) {
        guard let status = HTTPStatus(code: code) else {
            let msg = localizedDescription.localized()
            let error = NSError(message: msg)
            let alert = AlertController.alertWithError(error, level: level)
            alert.present()
            return
        }

        let msg = Strings.Error.http + "(\(status.code))"
        switch status {
        case .noResponse:
            let error = NSError(message: Strings.Error.appUpdate)
            let alert = AlertController.alertWithError(error, level: .require, handler: {
                guard let url = App.store.url else { return }
                UIApplication.shared.openURL(url)
            })
            alert.present()
        case .unauthorized:
            let error = NSError(message: msg)
            let alert = AlertController.alertWithError(error, level: .require, handler: {
                AppDelegate.shared().logout()
            })
            alert.present()
        default:
            let error = NSError(message: msg)
            let alert = AlertController.alertWithError(error, level: level)
            alert.present()
        }
    }
}

// MARK: Error Tracking
// Log error to Crashlytics and show required alert.
func fatal(_ msg: String) {
    let error = NSError(message: msg)
    Crashlytics.sharedInstance().recordError(error)
    #if RELEASE
        let msg = "問題が発生しました。\nアプリを再起動してください。"
    #else
        let msg = msg + "\nYou must restart this application.\nThanks you!"
    #endif
    DispatchQueue.main.async {
        let alert = AlertController(title: Bundle.main.name.localized(), message: msg, preferredStyle: .alert)
        alert.level = .require
        alert.present()
    }
}

// Log error to Crashlytics and show required alert on Debug/Staging.
func assert(_ cond: Bool, _ msg: String) {
    guard !cond else { return }
    let error = NSError(message: msg)
    Crashlytics.sharedInstance().recordError(error)
    #if !RELEASE
        DispatchQueue.main.async {
            let alert = AlertController(title: "DEBUG", message: msg, preferredStyle: .alert)
            alert.level = .require
            alert.present()
        }
    #endif
}
