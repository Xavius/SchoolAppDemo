//
//  UIView+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

extension UIView {
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    @discardableResult func embedIntoStack(_ views: [UIView],
                                           spacing: CGFloat = 0,
                                           distribution: UIStackView.Distribution = .fill,
                                           stackAxis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView{
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = stackAxis
        stackView.spacing = spacing
        stackView.distribution = distribution
        for view in views {
            stackView.addArrangedSubview(view)
        }
        if let view = self as? UIStackView {
            view.addArrangedSubview(stackView)
        } else {
            addView(stackView)
        }
        return stackView
    }

    func createSeparator(direction: NSLayoutConstraint.Axis = .horizontal,
                         color: UIColor = .saSeparator,
                         thickness: CGFloat = 1) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        switch direction {
            case .horizontal:
                view.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            case .vertical:
                view.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            default: break
        }
        return view
    }

    func setBackgroundImage(with image: UIImage?, moveToBack: Bool = true) {
        let bgrImageTag = -10
        let backgroundImage = self.subviews.first { $0.tag == bgrImageTag }
        if let backgroundImage = backgroundImage as? UIImageView {
            backgroundImage.image = image
        } else {
            let imageView = UIImageView()
            imageView.image = image
            imageView.tag = bgrImageTag
            self.addView(imageView)
            if moveToBack {
                self.sendSubviewToBack(imageView)
            }
            imageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1),
            ])
        }
    }
}
