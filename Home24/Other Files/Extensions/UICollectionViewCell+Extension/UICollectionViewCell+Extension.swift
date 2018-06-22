//
//  UICollectionViewCell+Extension.swift
//  Home24
//
//  Created by Everson Trindade on 20/06/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    class func createCell<T: UICollectionViewCell>(collectionView: UICollectionView, indexPath: IndexPath) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T ?? T()
    }
}
