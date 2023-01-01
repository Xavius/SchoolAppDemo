//
//  HomeMenuEntryCell.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

struct MenuItemData {
    enum ItemType {
        case common
        case mandatory
    }
    let icon: UIImage?
    let title: String
    let subTitle: String
    let itemType: ItemType
    let tapAction: () -> Void

    init(icon: UIImage?, title: String, subTitle: String, tapAction: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subTitle = subTitle
        self.itemType = .mandatory
        self.tapAction = tapAction
    }

    init(icon: UIImage?, title: String, tapAction: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subTitle = ""
        self.itemType = .common
        self.tapAction = tapAction
    }
}

class HomeMenuEntryCell: UICollectionViewCell {
    var layoutConstraints: [NSLayoutConstraint] = []

    let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 18)
        label.textColor = .black
        return label
    }()

    func setup(with data: MenuItemData) {
        self.backgroundColor = #colorLiteral(red: 0.9600479007, green: 0.9645254016, blue: 0.9906087518, alpha: 1)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true

        addView(iconView)
        addView(titleLabel)
        iconView.image = data.icon
        iconView.tintColor = #colorLiteral(red: 0.1450987458, green: 0.3700749278, blue: 0.7300561666, alpha: 1)
        titleLabel.text = data.title
        layoutConstraints = [
            iconView.centerYAnchor.constraint(equalTo: topAnchor, constant: 47),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate(layoutConstraints)
    }

}

extension HomeMenuEntryCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
