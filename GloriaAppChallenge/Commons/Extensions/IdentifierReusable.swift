//
//  IdentifierReusable.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 01/08/2021.
//

import UIKit

protocol IdentifierReusable {
    static var identifier: String { get }
}

extension IdentifierReusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: IdentifierReusable { }
extension UIViewController: IdentifierReusable { }
extension UICollectionReusableView: IdentifierReusable { }

extension UITableView {
    typealias ReusableCell = UITableViewCell
    
    func register<T: ReusableCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }
}

extension UICollectionView {
    typealias ReusableCollectionCell = UICollectionViewCell
    typealias ReusableCollectionReusableView = UICollectionReusableView
    
    func register<T: ReusableCollectionCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: ReusableCollectionReusableView>(_ cellType: T.Type, forSupplementaryViewOfKind kind: String) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
}
