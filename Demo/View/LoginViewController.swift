//
//  ViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

class LoginViewController: UIViewController {

    var model = UserViewModel(model: nil) {
        didSet {
            updateView()
        }
    }

    @IBOutlet fileprivate var nameField: UITextField!
    @IBOutlet fileprivate var mailField: UITextField!
    @IBOutlet fileprivate var passField: UITextField!
    @IBOutlet fileprivate var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupActions()
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
    }

    @objc private func login() {
        model.name =! nameField.text
        model.mail =! mailField.text
        model.pass =! passField.text

        switch model.validate() {
        case .success:
            model.login { (result) in
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

extension LoginViewController: MVVM.Presenter {
    func updateView() {
        guard isViewLoaded else { return }
        nameField.text = model.name
    }

    var identifier: String { return "LoginViewController" }
}
