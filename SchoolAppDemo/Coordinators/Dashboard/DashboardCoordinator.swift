//
//  DashboardCoordinator.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class DashboardCoordinator: Coordinator {
    // MARK: - Coordinator protocol conformance
    var navigationController: UINavigationController
    var flowCompletionHandler: Handler?
    func start() {
        showHomeController()
    }

    // MARK: - Properties
    private var needResetStack = true
    private weak var authController: AuthController?
    private let feesCoordinator: FeesCoordinator

    // MARK: - Initializers
    init(navigationController: UINavigationController, authController: AuthController?) {
        self.navigationController = navigationController
        self.authController = authController
        self.feesCoordinator = FeesCoordinator(navigationController: self.navigationController)
    }

    // MARK: - Private Methods
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
                case .showHoliday:
                    self?.showHoliday()
                case .showFees:
                    self?.showFees()
                default: break
            }
        }
        showViewController(homeVC)
    }

    private func showProfile() {
        let profileVC = DashboardFactory.createProfileController()
        // For now we don't care about action
        profileVC.completionHandler = { [weak self] _ in
            self?.navigationController.popViewController(animated: true)
        }
        showViewController(profileVC, with: "My Profile")
    }

    private func showAttendance() {
        let attendanceHolidaysVC = DashboardFactory.createAttendanceAndHolidaysController(withCurrentIndex: 0)
        showViewController(attendanceHolidaysVC, with: "")
    }

    private func showHoliday() {
        let attendanceHolidaysVC = DashboardFactory.createAttendanceAndHolidaysController(withCurrentIndex: 1)
        showViewController(attendanceHolidaysVC, with: "")
    }

    private func showFees() {
        feesCoordinator.start()
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
