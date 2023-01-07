//
//  SACollectionView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 05.01.2023.
//

import UIKit

class SACollectionView: UICollectionView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if point.y < 0 {
            return false
        }
        return super.point(inside: point, with: event)
    }
}
