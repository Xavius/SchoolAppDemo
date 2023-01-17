//
//  UICollectionView+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 17.01.2023.
//

import UIKit

extension UICollectionView {
    var widestCellWidth: CGFloat {
        let insets = contentInset.left + contentInset.right
        return bounds.width - insets
    }
}
