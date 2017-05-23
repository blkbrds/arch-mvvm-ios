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

final class NotifListViewModel: MVVM.ViewModel {
    weak var delegate: ViewModelDelegate?

    private var notifs: Results<Notif>?
    private var token: NotificationToken?

    func numberOfSections() -> Int {
        guard let _ = notifs else {
            return 0
        }
        return 1
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let notifs = notifs else {
            return 0
        }
        return notifs.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> ViewModel {
        guard let notifs = notifs else {
            fatalError("Please call `fetch()` first.")
        }
        let notif = notifs[indexPath.row]
        return NotifCellViewModel(notif: notif)
    }

    func viewModelForHeaderInSection(_ section: Int) -> ViewModel {
        fatalError()
    }

    // MARK: - Action

    func fetch() {
        notifs = RealmS().objects(Notif.self).sorted(byKeyPath: "id", ascending: true)
        token = notifs?.addNotificationBlock({ [weak self] (change) in
            guard let this = self else { return }
            this.notify(change: change)
        })
    }

    enum GetNotifsResult {
        case success
        case failure(Error)
    }

    typealias GetNotifsCompletion = (GetNotifsResult) -> Void

    func getNotifs(completion: @escaping GetNotifsCompletion) {
        let params = Api.Notif.QueryParams(type: .all, sort: .fullName, direction: .desc)
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
