//
//  UserProfileHeaderCollectionReusableView.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

class UserProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var avatarImageView:UIImageView?
    @IBOutlet weak var videosLabel:UILabel?
    @IBOutlet weak var followersLabel:UILabel?
    @IBOutlet weak var followingLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureHeader(pictureURL:URL?, videosCount:Int, followersCount:Int, followingCount:Int) {
        setPictureURL(url: pictureURL)
        setVideosCount(count: videosCount)
        setFollowersCount(count: videosCount)
        setFollowingCount(count: followingCount)
    }
    
    func setPictureURL(url:URL?) {
        if let url = url {
            let placeholder = UIImage(named: Constants.avatarDefaultImage)
            avatarImageView?.load(url: url, placeholder: placeholder)
        }
    }
    
    func setVideosCount(count:Int) {
        let videosText = count == 1 ? "profile_video_count".localized : "profile_videos_count".localized
        videosLabel?.text = String(format: videosText, count)
    }
    
    func setFollowersCount(count:Int) {
        let followersText = count == 1 ? "profile_follower_count".localized : "profile_followers_count".localized
        followersLabel?.text = String(format: followersText, count)
    }
    
    func setFollowingCount(count:Int) {
        followingLabel?.text = String(format: "profile_following_count".localized, count)
    }
}
