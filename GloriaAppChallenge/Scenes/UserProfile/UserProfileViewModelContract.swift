//
//  UserProfileViewModelContract.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit


protocol UserProfileViewModelContract {
    func getUserProfile(userId: Int)
    func userName() -> String
    func pictureURL() -> URL?
    func followersCount() -> Int
    func followingCount() -> Int
    func videos() -> [String]
    func profileIsLoadead() -> Bool
}

protocol UserProfileViewModelUpdate {
    func updateView()
    func showLoading()
    func hideLoading()
    func showError(error:String)
}
