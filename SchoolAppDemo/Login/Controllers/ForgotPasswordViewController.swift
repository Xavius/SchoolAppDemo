//
//  ForgotPasswordViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        return button
    }()
}

extension ForgotPasswordViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(dismissButton)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
    }

    override func configureView() {
        super.configureView()
        view.backgroundColor = .white
        dismissButton.addTarget(self, action: #selector(didTappedDismissButton), for: .touchUpInside)
    }
}

@objc extension ForgotPasswordViewController {
    func didTappedDismissButton() {
        dismiss(animated: true)
    }
}
