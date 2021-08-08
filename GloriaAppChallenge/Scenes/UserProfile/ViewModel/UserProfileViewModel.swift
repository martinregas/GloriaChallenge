//
//  UserProfileViewModel.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

class UserProfileViewModel {
    
    var view : UserProfileViewModelUpdate
    var service:UserProfileServiceContract
    var userProfile:UserProfile?
        
    required init(view: UserProfileViewModelUpdate) {
        self.view = view
        self.service = UserProfileService()
    }
    
    func getUserProfile(userId:Int) {
        view.showLoading()
        service.getUserProfile(userID: userId, completion: { userProfile in
            self.userProfile = userProfile
            self.view.updateView()
            self.view.hideLoading()
        }, failure: { error in
            self.view.hideLoading()
            self.view.showError(error: error)
        })
    }
}

extension UserProfileViewModel: UserProfileViewModelContract {
    func userName() -> String {
        return userProfile?.name ?? ""
    }
    
    func pictureURL() -> URL? {
        return URL(string: userProfile?.picture ?? "")
    }
    
    func followersCount() -> Int {
        return userProfile?.followersCount ?? 0
    }
    
    func followingCount() -> Int {
        return userProfile?.followingCount ?? 0
    }
    
    func videos() -> [String] {
        return userProfile?.videoPaths ?? []
    }
    
    func profileIsLoadead() -> Bool {
        return userProfile != nil
    }
}

