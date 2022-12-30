//
//  LoginButton.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 30.12.2022.
//

import UIKit

class LoginButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }

    let arrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.right")?.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    init() {
        super.init(frame: .zero)
        addView(arrow)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    func configure(with title: String) {
        setTitle(title.uppercased(), for: .normal)
        self.titleLabel?.font = .sourceSansPro(with: .semiBold, and: 16)
        applyGradient(colors: [#colorLiteral(red: 0.08351258188, green: 0.3299642503, blue: 0.7067704797, alpha: 1).cgColor, #colorLiteral(red: 0.415125519, green: 0.572653532, blue: 0.8321515918, alpha: 1).cgColor],
                      startPoint: CGPoint(x: 0.75, y: 1.65),
                      endPoint: CGPoint(x: 1.53, y: 0.54),
                      cornerRadius: 10)

        NSLayoutConstraint.activate([
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28.42),
            arrow.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.081)
        ])
        arrow.tintColor = self.titleLabel?.textColor
    }
}
