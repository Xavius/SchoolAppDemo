//
//  HolidayTableViewCell.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = {
        return String(describing: HolidayTableViewCell.self)
    }()
    private let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.saHolidayBorderGrey.cgColor
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .semiBold, and: 16)
        label.textColor = .saTitleGrey2
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 14)
        label.textColor = .saSubTitleGrey
        return label
    }()

    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 14)
        label.textColor = .saSubTitleGrey
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
    func setup(withTitle title: String?, andDate date: Date?) {
        titleLabel.text = title

        guard let date = date else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("ddMMMM")
        let dateString = dateFormatter.string(from: date)

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        let weekdayString = weekdayFormatter.string(from: date).capitalized

        dateLabel.text = dateString
        weekdayLabel.text = weekdayString
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureView()
    }
}

extension HolidayTableViewCell: BaseViewProtocol {
    func setupViews() {
        addView(mainContentView)
        mainContentView.addView(titleLabel)
        mainContentView.addView(dateLabel)
        mainContentView.addView(weekdayLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),

            titleLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 15),

            dateLabel.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -16),
            dateLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 15),

            weekdayLabel.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -16),
            weekdayLabel.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -17),
        ])
    }

    func configureView() {
        self.backgroundColor = .clear
    }
}
