//
//  BaseViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureView()
    }
}

@objc extension BaseViewController: BaseViewProtocol {
    func setupViews() {
        view.setBackgroundImage(with: .backgroundSplash)
    }
    func setupConstraints() {}
    func configureView() {}
}

extension UIViewController {
    func setupNavBarBackButton(with title: String = "") {
        let button = UIBarButtonItem(title: title,
                                     style: .plain,
                                     target: self,
                                     action: nil)
        button.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.sourceSansPro(with: .regular, and: 18),
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ], for: .normal)
        navigationItem.backBarButtonItem = button
    }
}
