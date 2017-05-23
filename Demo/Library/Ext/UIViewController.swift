//
//  UIKitEx.swift
//  Demo
//
//  Created by DaoNV on 5/23/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(error: Error) {
        alert(title: "ERROR", msg: error.localizedDescription, buttons: ["OK"], handler: nil)
    }

    func alert(title: String? = nil, msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .cancel, handler: { action in
                handler?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
