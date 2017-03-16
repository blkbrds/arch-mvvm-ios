//
//  ViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    var user = UserViewModel() {
        didSet {
            updateView()
        }
    }

    var nameField: UITextField!
    var mailField: UITextField!
    var passField: UITextField!
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupActions()
    }

    private func updateView() {
        guard isViewLoaded else { return }
        nameField.text = user.name
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
    }

    @objc private func login() {
        user.name = nameField.string
        user.mail = mailField.string
        user.pass = passField.string
        switch user.validate() {
        case .success:
            user.login { (result) in
                //
            }
        case .failure(let key, let msg):
            let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
                guard let this = self else { return }
                guard let field = this.textField(forKey: key) else { return }
                field.becomeFirstResponder()
            }))
        }
    }

    func textField(forKey key: String) -> UITextField? {
        switch key {
        case "name":
            return nameField
        case "mail":
            return mailField
        case "pass":
            return passField
        default:
            return nil
        }
    }
}

extension UITextField {
    var string: String { return text ?? "" }
}
