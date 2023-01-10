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
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    func setup(name: String, action: Selector, target: Any?) {
        buttonTitle.text = name.uppercased()
        self.addTarget(target, action: action, for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30),

            buttonTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -1),
            buttonTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            checkMark.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkMark.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.52),
            checkMark.trailingAnchor.constraint(equalTo: buttonTitle.leadingAnchor, constant: -7.29),
            checkMark.widthAnchor.constraint(equalTo: checkMark.heightAnchor, multiplier: 1.7),
            checkMark.heightAnchor.constraint(equalToConstant: 12),
        ])
    }

}
