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

    private func updateView() {
        guard isViewLoaded else { return }
        mailField.text = viewModel.mail
        passField.text = viewModel.pass
    }
    // MARK: -

    @IBOutlet fileprivate var mailField: UITextField!
    @IBOutlet fileprivate var passField: UITextField!
    @IBOutlet fileprivate var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            viewModel.mail = "at.ios.mvvm@gmail.com"
            viewModel.pass = "Abc@123"
        #endif
        updateView()
        setupActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !passField.isFirstResponder else { return }
        mailField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
    }

    @objc private func login() {
        viewModel.mail =! mailField.text?.trimmed
        viewModel.pass =! passField.text?.trimmed

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

    private func performSegue(_ segue: Segue) {
        performSegue(withIdentifier: segue.rawValue, sender: self)
    }

    private func showRepoList() {
        performSegue(.showRepoList)
    }

    var textFields: [String:UITextField] {
        return [
            "mail": mailField,
            "pass": passField
        ]
    }
}

extension String {
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
