//
//  UIView+Extension.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

extension UIView {
    func round() {
        self.layer.cornerRadius = self.frame.size.height/2
    }
}
