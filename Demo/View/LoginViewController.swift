//
//  LoginViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class LoginViewController: UIViewController, MVVM.Presenter {
    // MARK: - MVVM
    typealias T = UserViewModel
    var viewModel = UserViewModel(model: nil)

    func updateView(viewModel: UserViewModel) {
        self.viewModel = viewModel
        guard isViewLoaded else { return }
        nameField.text = viewModel.name
    }
    // MARK: -

    @IBOutlet fileprivate var nameField: UITextField!
    @IBOutlet fileprivate var mailField: UITextField!
    @IBOutlet fileprivate var passField: UITextField!
    @IBOutlet fileprivate var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(viewModel: viewModel)
        setupActions()
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
    }

    @objc private func login() {
        viewModel.name =! nameField.text
        viewModel.mail =! mailField.text
        viewModel.pass =! passField.text

        switch viewModel.validate() {
        case .success:
            viewModel.login { (result) in
                //
            }
        case .failure(let key, let msg):
            let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
                guard let this = self else { return }
                guard let field = this.textFields[key] else { return }
                field.becomeFirstResponder()
            }))
            
            self.present(alert, animated: true, completion: nil)
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
