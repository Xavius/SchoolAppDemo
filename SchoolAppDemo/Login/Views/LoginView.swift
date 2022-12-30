//
//  LoginView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class LoginView: BaseView {
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .semiBold, and: 34)
        label.textColor = .saTitleGrey
        label.text = "Hi Student"
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 20)
        label.textColor = .saSubTitleGrey
        label.text = "Sign in to continue"
        return label
    }()

    let emailInputView: SATextField = {
        let inputView = SATextField(with: "Mobile Number/Email", and: .email)
        return inputView
    }()

    let passInputView: SATextField = {
        let inputView = SATextField(with: "Password", and: .password)
        return inputView
    }()

    let loginImage: UIImageView = {
        let imageView = UIImageView(image: .loginImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var loginButton = LoginButton()

    var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.saTitleGrey, for: .normal)
        button.titleLabel?.font = .sourceSansPro(with: .regular, and: 16)
        return button
    }()

    func addSignInAction(_ action: Selector, with target: Any?) {
        loginButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func addForgotPasswordAction(_ action: Selector, with target: Any?) {
        forgotPasswordButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension LoginView {
    override func setupViews() {
        super.setupViews()
        setBackgroundImage(with: .backgroundSplash)
        addView(contentView)
        addView(titleLabel)
        addView(subTitleLabel)
        addView(emailInputView)
        addView(passInputView)
        addView(loginButton)
        addView(forgotPasswordButton)

        addView(loginImage)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.592),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 74),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 25),

            emailInputView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 41),
            emailInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            passInputView.topAnchor.constraint(equalTo: emailInputView.bottomAnchor, constant: 35),
            passInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            loginButton.topAnchor.constraint(equalTo: passInputView.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 0.17),

            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),

            loginImage.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 25.86),
            loginImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginImage.heightAnchor.constraint(equalToConstant: 161.33),
        ])
    }

    override func configureView() {
        super.configureView()
        loginButton.configure(with: "Sign In")
    }
}
