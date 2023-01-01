//
//  ProfileViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

class ProfileViewController: BaseViewController {
    let profileView = ProfileView()
}

extension ProfileViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(profileView)
        profileView.setupViews()
    }
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        profileView.setupConstraints()
    }
    override func configureView() {
        super.configureView()
        profileView.configureView()
    }
}
