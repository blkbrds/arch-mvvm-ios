//
//  LoginViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

private enum Segue: String {
    case showRepoList
}

final class LoginViewController: UIViewController, MVVM.View {
    // MARK: - MVVM
    typealias T = LoginViewModel
    var viewModel = LoginViewModel(user: nil) {
        didSet {
            updateView()
        }
    }

    // MARK: -

    @IBOutlet fileprivate var usernameField: UITextField!
    @IBOutlet fileprivate var tokenField: UITextField!
    @IBOutlet fileprivate var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            viewModel.username = "at-ios-mvvm"
            viewModel.token = "101a6476440c30431a17" + "25c310d1abe049189b2a"
        #endif
        updateView()
        setupActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !tokenField.isFirstResponder else { return }
        usernameField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    var textFields: [String: UITextField] {
        return [
            "mail": usernameField,
            "pass": tokenField
        ]
    }
}

// MARK: - Private
extension LoginViewController {
    fileprivate func setupActions() {
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
    }

    @objc fileprivate func login() {
        viewModel.username = usernameField.string.trimmed
        viewModel.token = tokenField.string.trimmed

        switch viewModel.validate() {
        case .success:
            viewModel.login { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success:
                    this.showRepoList()
                case .failure(let error):
                    NSLog("ERROR: " + error.localizedDescription)
                }
            }
        case .failure(let key, let msg):
            let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
                guard let this = self else { return }
                guard let field = this.textFields[key] else { return }
                field.becomeFirstResponder()
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    fileprivate func updateView() {
        guard isViewLoaded else { return }
        usernameField.text = viewModel.username
        tokenField.text = viewModel.token
    }

    fileprivate func performSegue(_ segue: Segue) {
        performSegue(withIdentifier: segue.rawValue, sender: self)
    }

    fileprivate func showRepoList() {
        performSegue(.showRepoList)
    }
}
