//
//  ForgotPasswordController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class ForgotPasswordController: UIViewController, BaseViewProtocol {
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        configureView()
    }
}

extension ForgotPasswordController {
    func setupViews() {
        view.addView(dismissButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
    }

    func configureView() {
        view.backgroundColor = .white
        dismissButton.addTarget(self, action: #selector(didTappedDismissButton), for: .touchUpInside)
    }
}

@objc extension ForgotPasswordController {
    func didTappedDismissButton() {
        dismiss(animated: true)
    }
}
