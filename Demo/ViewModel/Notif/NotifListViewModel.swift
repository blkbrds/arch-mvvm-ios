//
//  NotifListViewModel.swift
//  Demo
//
//  Created by DaoNV on 5/21/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import RealmS
import MVVM

class NotifListViewModel: MVVM.CollectionViewModel {
    weak var delegate: CollectionViewModelDelegate?

    private var Notifs: Results<Notif>?
    private var token: NotificationToken?

    func numberOfSections() -> Int {
        guard let _ = Notifs else {
            return 0
        }
        return 1
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let Notifs = Notifs else {
            return 0
        }
        return Notifs.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> NotifCellViewModel {
        guard let Notifs = Notifs else {
            fatalError("Please call `fetch()` first.")
        }
        let Notif = Notifs[indexPath.row]
        return NotifCellViewModel(notif: Notif)
    }

    func viewModelForItem(at indexPath: IndexPath) -> NotifyCellViewModel {
        //
    }

    // MARK: - Action

    func fetch() {
        Notifs = RealmS().objects(Notif.self).sorted(byKeyPath: "id", ascending: true)
        token = Notifs?.addNotificationBlock({ [weak self] (change) in
            guard let this = self else { return }
            this.delegate?.viewModel(change: change.changes)
        })
    }

    enum GetNotifsResult {
        case success
        case failure(Error)
    }

    typealias GetNotifsCompletion = (GetNotifsResult) -> Void

    func getNotifs(completion: @escaping GetNotifsCompletion) {
        let params = Api.Notif.QueryParams(
            type: .all,
            sort: .full_name,
            direction: .desc
        )
        Api.Notif.query(params: params) { (result) in
            RealmS().refresh()
            switch result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
