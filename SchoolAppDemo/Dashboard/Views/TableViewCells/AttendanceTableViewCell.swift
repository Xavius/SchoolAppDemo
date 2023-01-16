//
//  AttendanceTableViewCell.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = {
        return String(describing: AttendanceTableViewCell.self)
    }()
    private let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    private let leftView = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 14)
        label.textColor = .saCellTitleGrey
        return label
    }()
    private let rightView = UIView()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .bold, and: 13)
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func setup(withTitle title: String?, value: Int, andType type: DayCellType) {
        titleLabel.text = title
        valueLabel.text = "\(value)"
        switch type {
            case .absence:
                mainContentView.layer.borderColor = UIColor.saAbsence.cgColor
                leftView.backgroundColor = .saAbsence
                rightView.backgroundColor = .saAbsenceSecondary
                valueLabel.textColor = .saAbsence
            case .holiday:
                mainContentView.layer.borderColor = UIColor.saHoliday.cgColor
                leftView.backgroundColor = .saHoliday
                rightView.backgroundColor = .saHolidaySecondary
                valueLabel.textColor = .saHoliday
            default:
                mainContentView.layer.borderColor = backgroundColor?.cgColor
                leftView.backgroundColor = .clear
                rightView.backgroundColor = .clear
                valueLabel.textColor = titleLabel.textColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureView()
    }
}

// MARK: - BaseViewProtocol
extension AttendanceTableViewCell: BaseViewProtocol {
    func setupViews() {
        addView(mainContentView)
        mainContentView.addView(leftView)
        mainContentView.addView(titleLabel)
        mainContentView.addView(rightView)
        mainContentView.addView(valueLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),

            leftView.topAnchor.constraint(equalTo: mainContentView.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor),
            leftView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor),
            leftView.widthAnchor.constraint(equalToConstant: 16),

            titleLabel.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 12),

            rightView.centerYAnchor.constraint(equalTo: mainContentView.centerYAnchor),
            rightView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -11),
            rightView.widthAnchor.constraint(equalToConstant: 28),
            rightView.heightAnchor.constraint(equalTo: rightView.widthAnchor),

            valueLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
        ])
    }

    func configureView() {
        self.backgroundColor = .clear
        rightView.layer.cornerRadius = rightView.frame.width / 2
    }
}
