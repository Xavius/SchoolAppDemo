//
//  LoginViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

enum LoginAction {
    case signIn
    case signUp
    case forgotPassword
}
class LoginViewController: BaseViewController, FlowController {
    // MARK: - Properties
    let loginView: LoginView = {
        let view = LoginView()
        return view
    }()
    var completionHandler: ((LoginAction?) -> ())?

    // MARK: - Public Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - BaseViewProtocol
extension LoginViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(loginView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
        loginView.addSignInAction(#selector(didTappedLoginButton), with: self)
        loginView.addForgotPasswordAction(#selector(didTappedForgotPasswordButton), with: self)
    }
}

// MARK: - Button Events
@objc extension LoginViewController {
    func didTappedLoginButton() {
        if let authController = authController() {
            authController.signIn()
            if authController.isSignedIn {
                completionHandler?(.signIn)
            }
        }
    }

    func didTappedForgotPasswordButton() {
        completionHandler?(.forgotPassword)
    }
}
