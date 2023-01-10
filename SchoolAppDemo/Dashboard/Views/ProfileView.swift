//
//  ProfileView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

class ProfileView: BaseView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset.top = 30
        return scrollView
    }()

    let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 29
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        return contentView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 29
        stackView.layer.cornerRadius = 29
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.backgroundColor = .white
        return stackView
    }()

    let profilePanel: ProfilePanelView = {
        let profilePanel = ProfilePanelView()
        return profilePanel
    }()


    func setProfileImage(image: UIImage?) {
        profilePanel.setProfileImage(image: image)
    }

    func setChoseImageTarget(action: Selector, target: Any?) {
        profilePanel.setChoseImageTarget(action: action, target: target)
    }
}

extension ProfileView {
    override func setupViews() {
        super.setupViews()
        addView(contentView)
        addView(profilePanel)
        profilePanel.setupViews()
        profilePanel.setup(with: "Akshay Syal",
                           and: .backgroundSplash,
                           and: "Class XI-B  |  Roll no: 04")
        addView(scrollView)
        scrollView.addView(stackView)
        for i in 1...7 {
            let textField = SATextField(with: "Field \(i)", and: .text)
            stackView.addArrangedSubview(textField)
        }
    }

    override func setupConstraints() {
        super.setupConstraints()
        profilePanel.setupConstraints()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            profilePanel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            profilePanel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profilePanel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

            scrollView.topAnchor.constraint(equalTo: profilePanel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -17),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -33),

        ])
    }

    override func configureView() {
        super.configureView()
        profilePanel.configureView()
    }
}
