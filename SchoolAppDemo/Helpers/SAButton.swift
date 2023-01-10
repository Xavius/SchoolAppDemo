//
//  SAButton.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 09.01.2023.
//

import UIKit

class SAButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }
}
