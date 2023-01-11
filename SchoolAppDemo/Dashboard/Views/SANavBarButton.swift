//
//  SANavBarButton.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 09.01.2023.
//

import UIKit

class SANavBarButton: SAButton {
    let checkMark: UIImageView = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold, scale: .large)
        let checkMarkImage = UIImage(systemName: "checkmark", withConfiguration: largeConfig)?
            .withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: checkMarkImage)
        imageView.tintColor = .saTextBlue
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let buttonTitle: UILabel = {
        let label = UILabel()
        label.text = "Temp"
        label.font = .sourceSansPro(with: .bold, and: 13)
        label.textColor = .saTextBlue
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView(checkMark)
        addView(buttonTitle)
        backgroundColor = .white
        layer.cornerRadius = 15

        heightAnchor.constraint(equalToConstant: 30).isActive = true

        buttonTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -1).isActive = true
        buttonTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        checkMark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkMark.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.52).isActive = true
        checkMark.trailingAnchor.constraint(equalTo: buttonTitle.leadingAnchor, constant: -7.29).isActive = true
        checkMark.widthAnchor.constraint(equalTo: checkMark.heightAnchor, multiplier: 1.7).isActive = true
        checkMark.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    func setup(name: String, action: Selector, target: Any?) {
        buttonTitle.text = name.uppercased()
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
