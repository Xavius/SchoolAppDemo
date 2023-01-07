//
//  Router.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 05.01.2023.
//

import UIKit

protocol Router {
    // MARK: - Login Screens
    func showLogin(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)

    // MARK: - Dashboard Screens
    func showDashboard(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func showProfile(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openQuiz(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openAssignment(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openHoliday(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openCalendar(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openResults(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openDateSheet(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openDoubts(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openGallery(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openChangePassword(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)
    func openEvents(from viewController: BaseViewController, animated: Bool, navBarTitle: String?)

    // MARK: - Common stuff
    func popScreen(from viewController: BaseViewController, animated: Bool)
}

struct MainRouter: Router {
    func openQuiz(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openAssignment(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openHoliday(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openCalendar(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openResults(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openDateSheet(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openDoubts(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openGallery(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openChangePassword(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    func openEvents(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle)
    }

    @discardableResult private func createAndPushController<VC: BaseViewController>(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) -> VC {
        if let navBarTitle = navBarTitle {
            viewController.setupNavBarBackButton(with: navBarTitle)
        }
        let vc = VC()
        vc.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(vc, animated: animated)
        return vc
    }

    func showLogin(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle) as LoginViewController
    }

    func showDashboard(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle) as HomeViewController
    }

    func showProfile(from viewController: BaseViewController, animated: Bool, navBarTitle: String?) {
        let _ = createAndPushController(from: viewController,
                                        animated: animated,
                                        navBarTitle: navBarTitle) as ProfileViewController
    }

    func popScreen(from viewController: BaseViewController, animated: Bool) {
        viewController.navigationController?.popViewController(animated: animated)
    }
}

extension BaseViewController {
    func router() -> Router? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else { return nil }
        return sceneDelegate.router
    }
}
