//
//  LoginController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class LoginController: UIViewController, BaseViewProtocol {
    let loginView: LoginView = {
        let view = LoginView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        configureView()
    }
}

extension LoginController {
    func setupViews() {
        view.addView(loginView)
        loginView.setupViews()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        loginView.setupConstraints()
    }

    func configureView() {
        loginView.configureView()
        loginView.addSignInAction(#selector(didTappedLoginButton), with: self)
        loginView.addForgotPasswordAction(#selector(didTappedForgotPasswordButton), with: self)
    }
}


@objc extension LoginController {
    func didTappedLoginButton() {
        print("Sign In Tapped")
    }

    func didTappedForgotPasswordButton() {
        let forgotPasswordVC = ForgotPasswordController()
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        present(forgotPasswordVC, animated: true)
    }
}
