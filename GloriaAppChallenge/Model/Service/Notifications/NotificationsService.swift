//
//  NotificationsService.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 20/07/2021.
//

import UIKit

protocol NotificationsServiceContract {
    func getNotifications(completion: @escaping ([Notification]) -> Void,
                          failure: @escaping (String) -> Void)
    func setNotificationAsViewed(notificationId:Int, completion: @escaping () -> Void,
                                 failure: @escaping (String) -> Void)
}

class NotificationsService: ApiService, NotificationsServiceContract {
    func getNotifications(completion: @escaping ([Notification]) -> Void,
                          failure: @escaping (String) -> Void) {
  
        let request = ApiRequest(path: .notifications, method: .get)

        self.request(request, completion: { (result: [Notification]) in
            completion(result)
        }, failure: { error in
            failure(error.localizedDescription)
        })
    }
    
    func setNotificationAsViewed(notificationId:Int, completion: @escaping () -> Void,
                                 failure: @escaping (String) -> Void) {
        //...
    }
}
