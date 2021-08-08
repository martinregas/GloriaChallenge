//
//  UIViewController+Extension.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 22/07/2021.
//

import Foundation
import UIKit

fileprivate var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.2)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func showAlertWith(title:String? = nil, message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "alert_button_title".localized, style: .default, handler: { _ in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        return alert
    }
    
    func createBarButtonItem(image:UIImage?, _ target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let buttomItem = UIBarButtonItem(customView: button)
        buttomItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        buttomItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        buttomItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return buttomItem
    }
}
