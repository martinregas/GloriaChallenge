//
//  UserProfileService.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

protocol UserProfileServiceContract {
    func getUserProfile(userID:Int, completion: @escaping (UserProfile) -> Void,
                        failure: @escaping (String) -> Void)
}

class UserProfileService: ApiService, UserProfileServiceContract {
    func getUserProfile(userID:Int, completion: @escaping (UserProfile) -> Void,
                        failure: @escaping (String) -> Void) {
  
        let parameters = ["id":userID]
        
        let request = ApiRequest(path: .userProfile, method: .get, parameters:parameters)

        self.request(request, completion: { (result: [UserProfile]) in
            guard let response = result.first else {
                failure("default_api_error".localized)
                return
            }
            completion(response)
        }, failure: { error in
            failure(error.localizedDescription)
        })
    }
}
