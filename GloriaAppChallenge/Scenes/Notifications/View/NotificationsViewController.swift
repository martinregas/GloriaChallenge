//
//  NotificationsViewController.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 20/07/2021.
//

import UIKit

class NotificationsViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView?
    
    lazy var viewModel : NotificationsViewModelContract = {
        let viewModel = NotificationsViewModel(view: self)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

        viewModel = NotificationsViewModel(view: self)
        viewModel.getNotifications()
        setTitle(title: "notifications_screen_title".localized)

        showCloseButton()
    }
    
    func configureTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(NotificationTableViewCell.self)
    }
    
    func goToUserProfile(userId:Int) {
        let userProfileVC = UserProfileViewController(nibName: UserProfileViewController.identifier, bundle: nil)
        userProfileVC.userId = userId
        self.navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    func goToPost(postId:Int) {
        //..
    }
}

extension NotificationsViewController: NotificationsViewModelUpdate {
    func updateTable() {
        tableView?.reloadData()
    }
    
    func showLoading() {
        showSpinner(onView: view)
    }
    
    func hideLoading() {
        removeSpinner()
    }
    
    func showError(error:String) {
        let alert = showAlertWith(message: error)
        present(alert, animated: true, completion: nil)
    }
}

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notificationsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell {
            
            let notification = viewModel.getNotification(index: indexPath.row)
                        
            cell.configureCell(title: notification.titleFormated ?? NSAttributedString(string: notification.text), imagePath: notification.picture, viewed: notification.viewed,type: notification.type)
            
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell()
    }
}

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setNotificationAsViewed(index: indexPath.row)
        tableView.reloadData()
        
        let notification = viewModel.getNotification(index: indexPath.row)
        
        guard let notificationValue = notification.value else { return }
        
        switch  notification.type {
        case .post:
            goToPost(postId: notificationValue)
        break
        case .profile:
            goToUserProfile(userId: notificationValue)
        break
            
        }   
    }
}

