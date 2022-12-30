//
//  UITextField+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

extension UITextField {
    func enableEyeIcon() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = #colorLiteral(red: 0.7722417712, green: 0.7963572145, blue: 0.835131824, alpha: 1)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        self.rightViewMode = .always
        self.rightView = button
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        if let button = self.rightView as? UIButton {
            let imageName = self.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
            button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = #colorLiteral(red: 0.7722417712, green: 0.7963572145, blue: 0.835131824, alpha: 1)
        }
    }
}
