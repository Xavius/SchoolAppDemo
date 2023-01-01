//
//  ProfileButton.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

class ProfileButton: UIButton {
    let userpic: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7921568751, green: 0.7921569347, blue: 0.7921568751, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width * 0.5
        imageView.clipsToBounds = true
        return imageView
    }()

    func configure(with image: UIImage?) {
        self.layoutIfNeeded()
        self.backgroundColor = .white
        self.clipsToBounds = true
        if let image = image {
            userpic.image = image
        }
        addView(userpic)
        NSLayoutConstraint.activate([
            userpic.centerXAnchor.constraint(equalTo: centerXAnchor),
            userpic.centerYAnchor.constraint(equalTo: centerYAnchor),
            userpic.widthAnchor.constraint(equalTo: widthAnchor, constant: -4),
            userpic.heightAnchor.constraint(equalTo: heightAnchor, constant: -4),
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.size.width * 0.5
        userpic.layer.cornerRadius = userpic.frame.width * 0.5
    }
}
