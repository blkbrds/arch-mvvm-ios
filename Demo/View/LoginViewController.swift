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
    case ShowRepoList
}

final class LoginViewController: UIViewController, MVVM.Presenter {
    // MARK: - MVVM
    typealias T = UserViewModel
    var viewModel = UserViewModel(model: nil)

    func updateView(viewModel: UserViewModel) {
        self.viewModel = viewModel
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
        updateView(viewModel: viewModel)
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
        viewModel.mail =! mailField.text
        viewModel.pass =! passField.text

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

    private func showRepoList() {
        performSegue(withIdentifier: Segue.ShowRepoList.rawValue, sender: self)
    }

    var textFields: [String:UITextField] {
        return [
            "mail": mailField,
            "pass": passField
        ]
    }
}
