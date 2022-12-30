//
//  UIView+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

extension UIView {
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func setBackgroundImage(with image: UIImage?) {
        let bgrImageTag = -10
        let backgroundImage = self.subviews.first { $0.tag == bgrImageTag }
        if let backgroundImage = backgroundImage as? UIImageView {
            backgroundImage.image = image
        } else {
            let imageView = UIImageView()
            imageView.image = image
            imageView.tag = bgrImageTag
            self.addView(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1),
            ])
        }
    }
}
