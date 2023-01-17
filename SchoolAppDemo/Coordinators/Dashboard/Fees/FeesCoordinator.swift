//
//  FeesCoordinator.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

class FeesCoordinator: Coordinator {
    // MARK: - Coordinator protocol conformance
    var navigationController: UINavigationController
    var flowCompletionHandler: Handler?
    func start() {
        showFeesController()
    }

    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Private Methods
    private func showFeesController() {
        let feesVC = FeesFactory.createFeesController()
        showViewController(feesVC, with: "Fees Due")
    }

    private func showViewController(_ viewController: UIViewController, with title: String? = nil) {
        if let title = title {
            navigationController.visibleViewController?.setupNavBarBackButton(with: title)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
