//
//  SASegmentedControl.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 11.01.2023.
//

import UIKit

class SASegmentedControl: UIControl {
    var buttons: [UIButton] = []
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 23
        return stackView
    }()

    let selector: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
        return view
    }()

    var selectedIndex: Int {
        return buttons.firstIndex(where: \.isSelected) ?? 0
    }

    init(withItems buttonTitles: [String], andSelectedIndex index: Int = 0) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.562979579, green: 0.6945801377, blue: 0.9164603353, alpha: 1)
        layer.cornerRadius = 14

        for buttonTitle in buttonTitles {
            let button = UIButton(type: .custom)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        let selectedIndex = min(max(index, 0), buttons.count - 1)
        setButtonSelected(buttons[selectedIndex], true)

        addSubview(selector)
        addView(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 26).isActive = true
        heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        moveSelector(to: selectedIndex, animated: false)
    }

    private func setButtonSelected(_ button: UIButton?, _ isSelected: Bool) {
        guard let button = button else { return }
        button.isSelected = isSelected
        button.setTitleColor(isSelected ? .saTextBlue : .white, for: .normal)
    }
}

@objc private extension SASegmentedControl {
    func moveSelector(to index: Int, animated: Bool) {
        if !animated {
            selector.frame = buttons[index].frame
            selector.frame.size.width += 26
        } else {
            UIView.animate(withDuration: 0.1, delay: 0) {
                self.selector.frame = self.buttons[index].frame
                self.selector.frame.size.width += 26
            }
        }
    }
    func didTapButton(sender: UIButton) {
        if sender.isSelected {
            return
        }

        for (index, button) in buttons.enumerated() {
            let isSender = button == sender
            setButtonSelected(button, isSender)
            if isSender {
                moveSelector(to: index, animated: true)
                sendActions(for: .valueChanged)
            }
        }
    }
}
