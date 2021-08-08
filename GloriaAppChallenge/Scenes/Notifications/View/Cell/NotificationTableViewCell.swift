//
//  NotificationTableViewCell.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 27/07/2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    let POST_IMAGE_WIDTH = 40
    let PROFILE_IMAGE_WIDTH = 48
    
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var viewedMarkerView:UIView?
    @IBOutlet weak var notificationImageView:UIImageView?
    @IBOutlet weak var imageViewWidth:NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewedMarkerView?.round()
    }

    func configureCell(title:NSAttributedString, imagePath:String, viewed:Bool, type:NotificationType) {
        setTitle(title: title)
        setImage(imagePath: imagePath, type:type)
        setViewedMarkerVisibility(viewed: viewed)
    }
    
    private func setTitle(title:NSAttributedString) {
        titleLabel?.attributedText = title
    }
    
    private func setImage(imagePath:String, type:NotificationType) {
        if let url = URL(string: imagePath) {
            loadImage(url: url, type: type)
        }
    }
    
    private func loadImage(url:URL, type:NotificationType) {
        let placeholder = UIImage(named: Constants.avatarDefaultImage)
        self.notificationImageView?.load(url: url, placeholder: placeholder, completion: {
            self.setImageViewShape(type: type)
        })
    }
    
    private func setViewedMarkerVisibility(viewed:Bool) {
        viewedMarkerView?.isHidden = viewed
    }
    
    private func setImageViewShape(type:NotificationType) {
        switch type {
        case .profile:
            imageViewWidth?.constant = CGFloat(PROFILE_IMAGE_WIDTH)
            notificationImageView?.round()
        case .post: 
            imageViewWidth?.constant = CGFloat(POST_IMAGE_WIDTH)
            notificationImageView?.layer.cornerRadius = 5
        }
    }
}
