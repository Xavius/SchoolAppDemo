//
//  BaseView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

protocol BaseViewProtocol {
    func setupViews()
    func setupConstraints()
    func configureView()
}

class BaseView: UIView, BaseViewProtocol {
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }
}

extension BaseView {
    @objc func setupViews() {}
    @objc func setupConstraints() {}
    @objc func configureView() {}
}
