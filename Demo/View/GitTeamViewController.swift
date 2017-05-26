//
//  GitTeamViewController.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/26/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

class GitTeamViewController: UIViewController, MVVM.View {
    var viewModel = LoginViewModel(user: nil) {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var slugLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nemberCountLabel: UILabel!
    @IBOutlet weak var repoCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private
extension GitTeamViewController {
    func updateView() {
        guard isViewLoaded else { return }
    }
}
