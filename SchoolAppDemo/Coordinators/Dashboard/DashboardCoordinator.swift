//
//  DashboardCoordinator.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class DashboardCoordinator: Coordinator {
    var navigationController: UINavigationController
    var flowCompletionHandler: Handler?
    var needResetStack = true

    weak var authController: AuthController?

    init(navigationController: UINavigationController, authController: AuthController?) {
        self.navigationController = navigationController
        self.authController = authController
    }

    func start() {
        showHomeController()
    }

    private func showHomeController() {
        let homeVC = DashboardFactory.createHomeController()
        homeVC.completionHandler = { [weak self] action in
            guard let action = action else { return }
            switch action {
                case .logout:
                    self?.authController?.signOut()
                    self?.flowCompletionHandler?()
                case .showProfile:
                    self?.showProfile()
                case .showAttendance:
                    self?.showAttendance()
                case .showFees:
                    self?.showFees()
                default: break
            }
        }
        showViewController(homeVC)
    }

    private func showProfile() {
        let profileVC = DashboardFactory.createProfileController()
        showViewController(profileVC, with: "My Profile")
    }

    private func showAttendance() {
        let attendanceVC = DashboardFactory.createAttendanceController()
        showViewController(attendanceVC, with: "")
    }

    private func showFees() {
        let feesVC = DashboardFactory.createFeesController()
        showViewController(feesVC, with: "Fees Due")
    }

    private func showViewController(_ viewController: UIViewController, with title: String? = nil) {
        if let title = title {
            navigationController.visibleViewController?.setupNavBarBackButton(with: title)
        }
        if needResetStack {
            navigationController.setViewControllers([viewController], animated: true)
            needResetStack = false
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
