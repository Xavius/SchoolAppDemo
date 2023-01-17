//
//  FeesViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class FeesViewController: BaseViewController {
    // MARK: - Properties
    private let calendarHelper = CalendarHelper()
    private let feesView: FeesView = {
        let view = FeesView()
        return view
    }()
    private lazy var receipts: [ReceiptData] = {
        [
            .init(type: .notPaid,
                  number: 98761,
                  month: calendarHelper.makeMonth(year: 2020, month: 10),
                  paymentDate: calendarHelper.makeDate(year: 2020, month: 10, day: 10),
                  amount: 999),
            .init(type: .paid,
                  payMode: .cash,
                  number: 98431,
                  month: calendarHelper.makeMonth(year: 2020, month: 9),
                  paymentDate: calendarHelper.makeDate(year: 2020, month: 9, day: 10),
                  amount: 999),
            .init(type: .paid,
                  payMode: .cash,
                  number: 98231,
                  month: calendarHelper.makeMonth(year: 2020, month: 8),
                  paymentDate: calendarHelper.makeDate(year: 2020, month: 8, day: 10),
                  amount: 999),
        ]
    }()
}

// MARK: - BaseViewProtocol
extension FeesViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(feesView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            feesView.topAnchor.constraint(equalTo: view.topAnchor),
            feesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
        feesView.setup(with: receipts, and: self)
    }
}

// MARK: - ReceiptViewCellDelegate
extension FeesViewController: ReceiptViewCellDelegate {
    func didTapPay(receiptNumber: Int) {
        print("Pay for receipt: \(receiptNumber)")
    }

    func didTapDownload(receiptNumber: Int) {
        print("Download receipt: \(receiptNumber)")
    }
}
