//
//  MainViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    let isLoggedIn: Bool = {
        var isLoggedIn = false // TODO: check sign in status
        return isLoggedIn
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isLoggedIn {
            openLoginView()
        }
        view.backgroundColor = .systemRed
    }
    

    func openLoginView() {
        let loginVC = LoginController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false)
    }

}
