//
//  ProfilePanelView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 09.01.2023.
//

import UIKit

class ProfilePanelView: BaseView {
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7921568751, green: 0.7921569347, blue: 0.7921568751, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    let userName: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .bold, and: 20)
        label.textColor = .black
        return label
    }()

    let choseImageButton: SAButton = {
        let button = SAButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        let icon = UIImage(systemName: "camera", withConfiguration: largeConfig)?
            .withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.tintColor = .saSubTitleGrey
        return button
    }()

    let studentClassAndRoll: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 16)
        label.textColor = .saSubTitleGrey
        return label
    }()

    func setup(with name: String, and image: UIImage?, and classRoll: String) {
        setProfileImage(image: image)
        userName.text = name
        studentClassAndRoll.text = classRoll
    }

    func setChoseImageTarget(action: Selector, target: Any?) {
        choseImageButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func setProfileImage(image: UIImage?) {
        if let image = image {
            profileImage.image = image
        }
    }
}

extension ProfilePanelView {
    override func setupViews() {
        super.setupViews()
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.2792213559, green: 0.469811976, blue: 0.7794986367, alpha: 1)
        addView(profileImage)
        addView(userName)
        addView(choseImageButton)
        addView(studentClassAndRoll)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalToConstant: 75),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),

            userName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),

            choseImageButton.centerYAnchor.constraint(equalTo: userName.centerYAnchor),
            choseImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),

            studentClassAndRoll.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 9),
            studentClassAndRoll.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12)
        ])
    }

    override func configureView() {
        super.configureView()
    }
}
