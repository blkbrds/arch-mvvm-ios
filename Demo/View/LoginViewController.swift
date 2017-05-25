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
    var viewModel = LoginViewModel(user: nil) {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var accessTokenField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            viewModel.username = "at-ios-mvvm"
            viewModel.accessToken = "101a6476440c30431a17" + "25c310d1abe049189b2a"
        #endif
        updateView()
        setupActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if accessTokenField.isFirstResponder { return }
        usernameField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    func textField(for field: LoginViewModel.Field) -> UITextField {
        switch field {
        case .username: return usernameField
        case .accessToken: return accessTokenField
        }
    }
}

// MARK: - Private
extension LoginViewController {
    fileprivate func setupActions() {
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

    @objc private func login() {
        viewModel.username = usernameField.string.trimmed
        viewModel.accessToken = accessTokenField.string.trimmed

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
                this.viewDidUpdated()
            }
        case .failure(let field, let msg):
            alert(title: Strings.error, msg: msg, buttons: [Strings.ok], handler: { [weak self] _ in
                guard let this = self else { return }
                let fld = this.textField(for: field)
                fld.becomeFirstResponder()
            })
            viewDidUpdated()
        }
    }

    func updateView() {
        guard isViewLoaded else { return }
        usernameField.text = viewModel.username
        accessTokenField.text = viewModel.accessToken
    }

    fileprivate func performSegue(_ segue: Segue) {
        performSegue(withIdentifier: segue.rawValue, sender: self)
    }

    fileprivate func showRepoList() {
        performSegue(.showRepoList)
    }
}
