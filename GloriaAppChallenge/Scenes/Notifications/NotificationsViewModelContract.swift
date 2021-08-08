//
//  NotificationsViewModelContract.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 27/07/2021.
//

import UIKit

protocol NotificationsViewModelContract {
    func getNotifications()
    func notificationsCount() -> Int
    func getNotification(index:Int) -> Notification
    func setNotificationAsViewed(index:Int)
}

protocol NotificationsViewModelUpdate {
    func updateTable()
    func showLoading()
    func hideLoading()
    func showError(error:String)
}
