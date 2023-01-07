//
//  LoginViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class LoginViewController: BaseViewController {
    let loginView: LoginView = {
        let view = LoginView()
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

extension LoginViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(loginView)
        loginView.setupViews()
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        loginView.setupConstraints()
    }

    override func configureView() {
        super.configureView()
        loginView.configureView()
        loginView.addSignInAction(#selector(didTappedLoginButton), with: self)
        loginView.addForgotPasswordAction(#selector(didTappedForgotPasswordButton), with: self)
    }
}


@objc extension LoginViewController {
    func didTappedLoginButton() {
        if let authController = authController() {
            authController.signIn()
            if authController.isSignedIn {
                router()?.popScreen(from: self, animated: true)
            }
        }
    }

    func didTappedForgotPasswordButton() {
        let forgotPasswordVC = ForgotPasswordViewController()
        forgotPasswordVC.modalPresentationStyle = .fullScreen
        present(forgotPasswordVC, animated: true)
    }
}
