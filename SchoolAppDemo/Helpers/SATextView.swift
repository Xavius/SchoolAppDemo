//
//  SATextView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 17.01.2023.
//

import UIKit

class SATextView: BaseView {
    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 14)
        label.textColor = .saCellTitleGrey2
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .semiBold, and: 14)
        label.textColor = .saTitleGrey
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    var stackView: UIStackView?

    // MARK: - Public Methods
    func setup(withTitle title: String, andText text: String) {
        titleLabel.text = title
        textLabel.text = text
    }
}

// MARK: - BaseViewProtocol
extension SATextView {
    override func setupViews() {
        super.setupViews()
        stackView = embedIntoStack([titleLabel, textLabel], distribution: .fill)
    }

    override func setupConstraints() {
        super.setupConstraints()
        if let stackView = stackView {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        }
    }
}
