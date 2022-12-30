//
//  UIButton+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 30.12.2022.
//

import UIKit

extension UIButton {
    func applyGradient(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, cornerRadius: CGFloat? = nil) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius ?? 0

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
