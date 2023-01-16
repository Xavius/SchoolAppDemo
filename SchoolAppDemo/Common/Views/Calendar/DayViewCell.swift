//
//  DayViewCell.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 14.01.2023.
//

import UIKit

enum DayViewCellType {
    case normal
    case weekend
    case holiday
    case absence
}

class DayViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier: String = {
        return String(describing: DayViewCell.self)
    }()

    private let dayTypeBackground: UIView = {
        let view = UIView()
        return view
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 14)
        label.textAlignment = .center
        label.textColor = .saTitleGrey2
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)

        setupViews()
        setupConstraints()
    }

    // MARK: - Public Methods
    func setup(with date: Date?, isCurrentMonth: Bool, cellType: DayViewCellType) {
        if let date = date {
            label.text = "\(Calendar.current.component(.day, from: date))"
            label.alpha = isCurrentMonth ? 1 : 0.5
        } else {
            label.text = ""
            label.alpha = 0
        }
        switch cellType {
            case .weekend:
                dayTypeBackground.backgroundColor = .saWeekend
                label.textColor = .saTitleGrey2
            case .holiday:
                dayTypeBackground.backgroundColor = .saHoliday
                label.textColor = .white
            case .absence:
                dayTypeBackground.backgroundColor = .saAbsence
                label.textColor = .white
            default:
                dayTypeBackground.backgroundColor = .clear
                label.textColor = .saTitleGrey2
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }
}

// MARK: - BaseViewProtocol
extension DayViewCell: BaseViewProtocol {
    func setupViews() {
        addView(dayTypeBackground)
        addView(label)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dayTypeBackground.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            dayTypeBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            dayTypeBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            dayTypeBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),

            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configureView() {
        dayTypeBackground.layer.cornerRadius = dayTypeBackground.frame.width / 2
    }
}
