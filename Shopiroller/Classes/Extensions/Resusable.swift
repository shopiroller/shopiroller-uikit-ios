//
//  Resusable.swift
//  shopiroller
//
//  Created by Görkem Gür on 26.09.2021.
//

import UIKit

// MARK: Reusable

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

// MARK: Reusable UITableViewCell

extension UITableViewCell: Reusable { }

// MARK: Reusable UITableView

extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type = T.self) {
        let bundle = Bundle(for: cellClass.self)
        if bundle.path(forResource: cellClass.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: bundle)
            register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
        }
    }
    
}

// MARK: Reusable UICollectionViewCell

extension UICollectionViewCell: Reusable { }

// MARK: Reusable UICollectionView

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellClass: T.Type = T.self) {
        let bundle = Bundle(for: cellClass.self)
        if bundle.path(forResource: cellClass.reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
    }
    
}
