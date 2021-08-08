//
//  NotificationsViewModel.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 20/07/2021.
//

import UIKit


class NotificationsViewModel {
    
    var view : NotificationsViewModelUpdate
    var service: NotificationsServiceContract
    var notifications = [Notification]()
    
    required init(view: NotificationsViewModelUpdate) {
        self.view = view
        self.service = NotificationsService()
    }
    
    private func prepareNotificationsTitle() {
        for (index, notification) in notifications.enumerated() {
            notifications[index].titleFormated = formatNotificationTitle(notification: notification)
        }
    }
    
    private func formatNotificationTitle(notification:Notification) -> NSMutableAttributedString {
        let attr = [NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 15)!]
        let mutableAttrString = NSMutableAttributedString(string: notification.text, attributes: attr)
        
        guard let replacements = notification.replacements else { return mutableAttrString }
        
        for replacement in replacements {
            if !mutableAttrString.mutableString.contains("%@") { break }

            let attributes = [NSAttributedString.Key.font: UIFont(name: "OpenSans-Bold", size: 15)!]
            let replacementFormatted = NSAttributedString(string: replacement, attributes: attributes)
            let rangeToBeReplaced = mutableAttrString.mutableString.range(of: "%@")
            mutableAttrString.replaceCharacters(in: rangeToBeReplaced, with: replacementFormatted)
        }

        return mutableAttrString
    }
    
    private func setNotificationAsViewed(notificationId:Int) {
        service.setNotificationAsViewed(notificationId:notificationId, completion: {
            //..
        }, failure: {_ in
            //..
        })
    }
}

extension NotificationsViewModel: NotificationsViewModelContract {
    func getNotifications() {
        view.showLoading()
        service.getNotifications(completion: { notifications in
            self.notifications.append(contentsOf: notifications)
            self.prepareNotificationsTitle()
            self.view.updateTable()
            self.view.hideLoading()
        }, failure: { error in
            self.view.hideLoading()
            self.view.showError(error: error)
        })
    }
    
    func notificationsCount() -> Int{
        return notifications.count
    }
    
    func getNotification(index:Int) -> Notification {
        return notifications[index]
    }
    
    func setNotificationAsViewed(index:Int) {
        notifications[index].viewed = true
        self.setNotificationAsViewed(notificationId: 0)
    }
}

