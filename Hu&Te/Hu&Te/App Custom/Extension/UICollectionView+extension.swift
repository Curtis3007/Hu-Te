//
//  UICollectionView+extension.swift
//  NovelBooks
//
//  Created by BigSur on 09/05/2021.
//

import Foundation
import UIKit

extension UICollectionView {
    
    // Cell
    func registerCellFromNib<T: UICollectionViewCell>(_ type: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellWithReuseIdentifier: "\(T.self)")
    }
    
    func registerCellFromClass<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: "\(T.self)")
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath)
        return cell as! T
    }
    // Header
    func registerHeaderFromXib<T: UICollectionReusableView>(_ type: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(T.self)")
    }
    
    func registerHeaderFromClass<T: UICollectionReusableView>(_ type: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(T.self)")
    }
    func dequeueHeader<T: UICollectionReusableView>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(T.self)", for: indexPath)
        return header as! T
    }
    
    // Footer
    func registerFooterFromXib<T: UICollectionReusableView>(_ type: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(T.self)")
    }
    
    func registerFooterFromClass<T: UICollectionReusableView>(_ type: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(T.self)")
    }
    
    
    func dequeueFooter<T: UICollectionReusableView>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(T.self)", for: indexPath)
        return cell as! T
    }
    
    
    
    
    
    
}
