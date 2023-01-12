//
//  AuthController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 05.01.2023.
//

import UIKit

class AuthController {
    enum AuthStatus {
        case initial
        case signedIn
        case signedOut
    }
    private var authStatus: AuthStatus = .initial
    var isSignedIn: Bool {
        return authStatus == .signedIn
    }

    func signIn() {
        authStatus = .signedIn
    }

    func signOut() {
        authStatus = .signedOut
    }
}

extension BaseViewController {
    func authController() -> AuthController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else { return nil }
        return sceneDelegate.authController
    }
}
