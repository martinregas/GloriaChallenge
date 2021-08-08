//
//  BaseViewController.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.tintColor = .black
        
        if let viewControllers = navigationController?.viewControllers,
            viewControllers.count > 1 {
            let backButtonItem = UIBarButtonItem(image: UIImage(named: Constants.backArrowImage), style: .plain, target: self, action: #selector(backToPreviousViewController))
            navigationController?.navigationBar.tintColor = .black
            navigationItem.leftBarButtonItems = [backButtonItem]
        }
    }
    
    func setTitle(title:String) {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 24)
        
        let titleItem = UIBarButtonItem(customView: titleLabel)
        
        if navigationItem.leftBarButtonItems != nil {
            navigationItem.leftBarButtonItems?.append(titleItem)
        }
        else {
            navigationItem.leftBarButtonItems = [titleItem]
        }
    }
    
    func showCloseButton() {
        let closeItem = createBarButtonItem(image: UIImage(named:Constants.closeIconImage), self, action: #selector(closePopup))

        navigationItem.rightBarButtonItem = closeItem
    }
        
    @objc private func backToPreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func closePopup() {
        dismiss(animated: true)
    }
}
