//
//  HomeMenuMandatoryEntryCell.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 02.01.2023.
//

import UIKit

class HomeMenuMandatoryEntryCell: HomeMenuEntryCell {
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 16)
        label.textColor = .saSubTitleGrey
        return label
    }()

    override func setup(with data: MenuItemData) {
        self.backgroundColor = .white
        self.layer.borderColor = #colorLiteral(red: 0.2792213559, green: 0.469811976, blue: 0.7794986367, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.clipsToBounds = true

        titleLabel.font = .bebasNeue(with: 40)
        titleLabel.textColor = .black

        addView(iconView)
        addView(titleLabel)
        addView(subTitleLabel)
        iconView.image = data.icon
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        layoutConstraints = [
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 22.5),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 13.5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ]
    }
}
