//
//  TeamViewController.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/26/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class TeamViewController: UIViewController, MVVM.View {
    var viewModel = TeamViewModel(teamId: 0) {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var slugLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nemberCountLabel: UILabel!
    @IBOutlet weak var repoCountLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navi = navigationController,
            let window = AppDelegate.shared.window {
            window.rootViewController = navi
        }
        viewModel.getTeamDetail { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.updateView()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func updateView() {
        guard isViewLoaded, let teamDetailViewModel = viewModel.teamDetailViewModel else { return }
        nameLabel.text = teamDetailViewModel.name
        slugLabel.text = teamDetailViewModel.slug
        descLabel.text = teamDetailViewModel.desc
        nemberCountLabel.text = teamDetailViewModel.memberCount
        repoCountLabel.text = teamDetailViewModel.repoCount
        viewDidUpdated()
    }
}
