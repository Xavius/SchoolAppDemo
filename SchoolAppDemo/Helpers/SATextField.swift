//
//  SATextField.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class SATextField: UIView {
    enum InputType {
        case text
        case readonly
        case email
        case phone
        case password
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 12)
        label.textColor = .saLightGrey
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .sourceSansPro(with: .regular, and: 16)
        textField.textColor = .saTextField
        return textField
    }()

    let horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.880713284, green: 0.8902342916, blue: 0.9118718505, alpha: 1)
        return view
    }()

    private func addTitle(_ title: String) {
        addView(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
        titleLabel.text = title
    }

    private func addTextField(_ type: InputType) {
        addView(textField)
        switch type {
            case .email:
                textField.spellCheckingType = .no
                textField.keyboardType = .emailAddress
            case .phone:
                textField.keyboardType = .phonePad
            case .password:
                textField.spellCheckingType = .no
                textField.isSecureTextEntry = true
                textField.enableEyeIcon()
            case .readonly:
                textField.isUserInteractionEnabled = false
                textField.enableLockIcon()
            default:
                break
        }
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func addSeparator() {
        addView(horizontalLine)
        NSLayoutConstraint.activate([
            horizontalLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 46),
            horizontalLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalLine.heightAnchor.constraint(equalToConstant: 1),
            horizontalLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    init(with title: String, and type: InputType) {
        super.init(frame: .zero)
        addTitle(title)
        addTextField(type)
        addSeparator()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}
