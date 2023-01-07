//
//  LoginFactory.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

enum LoginFactory {
    static func createLoginController() -> LoginViewController {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    static func createForgotPasswordController() -> ForgotPasswordViewController {
        let vc = ForgotPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    static func createRegisterController() -> RegisterViewController {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
