//
//  SceneDelegate.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 28.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let authController = AuthController()
    let appCoordinator: AppCoordinator

    override init() {
        self.appCoordinator = AppCoordinator(navigationController: UINavigationController(), authController: authController)
        self.appCoordinator.navigationController.modalPresentationStyle = .fullScreen
        self.appCoordinator.navigationController.navigationBar.tintColor = .white
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = appCoordinator.navigationController
        appCoordinator.start()
        window.makeKeyAndVisible()
        self.window = window
    }
}
