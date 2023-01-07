//
//  AppCoordinator.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    var flowCompletionHandler: Handler?

    lazy var loginCoordinator: LoginCoordinator = { [unowned self] in
        LoginCoordinator(navigationController: self.navigationController)
    }()
    let dashboardCoordinator: DashboardCoordinator

    weak var authController: AuthController?

    init(navigationController: UINavigationController, authController: AuthController?) {
        self.navigationController = navigationController
        self.authController = authController
        self.dashboardCoordinator = DashboardCoordinator(navigationController: self.navigationController,
                                                         authController: self.authController)
    }

    func start() {
        if !tryStartLoginFlow() {
            startMainFlow()
        }
    }

    @discardableResult private func tryStartLoginFlow() -> Bool{
        if !(authController?.isSignedIn ?? false) {
            self.loginCoordinator.flowCompletionHandler = { [weak self] in
                self?.startMainFlow()
            }
            loginCoordinator.start()
            return true
        }
        return false
    }

    private func startMainFlow() {
        self.dashboardCoordinator.flowCompletionHandler = { [weak self] in
            self?.tryStartLoginFlow()
        }
        dashboardCoordinator.start()
    }
}
