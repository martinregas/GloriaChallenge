//
//  MainViewController.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 20/07/2021.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers()
        
        for item in self.tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setViewControllers() {
        let homeViewController = HomeViewController(nibName: HomeViewController.identifier, bundle: nil)
        let settingsViewController = SettingsViewController(nibName: SettingsViewController.identifier, bundle: nil)

        viewControllers = [
            createNavController(for: homeViewController, title: "tab_home_title".localized, image: UIImage(named: Constants.homeIconImage)),
            createNavController(for: settingsViewController, title: "tab_settings_title".localized, image: UIImage(named: Constants.menuIconImage))
        ]
    }
    
    private func createNavController(for rootViewController: BaseViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.navigationBar.tintColor = .black
        
        let notificationsItem = createBarButtonItem(image: UIImage(named:Constants.notificationsIconImage), self, action: #selector(showNotificationsViewController))

        rootViewController.setTitle(title: title)
        rootViewController.navigationItem.rightBarButtonItem = notificationsItem
        return navController
    }
    
    @objc private func showNotificationsViewController() {
        let notificationsVC = NotificationsViewController(nibName: NotificationsViewController.identifier, bundle: nil)
        let navController = UINavigationController(rootViewController: notificationsVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
