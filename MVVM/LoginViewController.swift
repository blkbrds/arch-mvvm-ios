//
//  ViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

private struct Action {
    static let login = #selector(LoginViewController.login)
}

class LoginViewController: UIViewController {

    var user = UserViewModel() {
        didSet {
            updateView()
        }
    }

    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var mailField: UITextField!
    @IBOutlet private var passField: UITextField!
    @IBOutlet private var loginButton: UIButton!

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

    @objc fileprivate func login() {
        user.name =! nameField.text
        user.mail =! mailField.text
        user.pass =! passField.text

        switch user.validate() {
        case .success:
            user.login { (result) in
                //
            }
        case .failure(let key, let msg):
            let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
                guard let this = self else { return }
                guard let field = this.textFields[key] else { return }
                field.becomeFirstResponder()
            }))
        }
    }

    var textFields: [String:UITextField] {
        return [
            "name": nameField,
            "mail": mailField,
            "pass": passField
        ]
    }
}
