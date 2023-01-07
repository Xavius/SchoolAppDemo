//
//  LoginCoordinator.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    var flowCompletionHandler: Handler?
    var needResetStack = true

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLoginController()
    }

    private func showLoginController() {
        needResetStack = true
        let loginVC = LoginFactory.createLoginController()
        loginVC.completionHandler = { [weak self] action in
            guard let action = action else { return }
            switch action {
                case .signIn:
                    self?.flowCompletionHandler?()
                case .signUp:
                    self?.showRegisterController()
                case .forgotPassword:
                    self?.showForgotPasswordController()
            }
        }
        showViewController(loginVC)
    }
    private func showRegisterController() {
        let regVC = LoginFactory.createRegisterController()
        regVC.completionHandler = { [weak self] _ in
            self?.showLoginController()
        }
        showViewController(regVC)
    }
    private func showForgotPasswordController() {
        let forgotPassVC = LoginFactory.createForgotPasswordController()
        forgotPassVC.completionHandler = { [weak self] _ in
            self?.showLoginController()
        }
        showViewController(forgotPassVC)
    }

    private func showViewController(_ viewController: UIViewController) {
        if needResetStack {
            navigationController.setViewControllers([viewController], animated: true)
            needResetStack = false
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
