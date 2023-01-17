//
//  ReceiptViewCell.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 17.01.2023.
//

import UIKit

enum ReceiptType {
    case paid
    case notPaid
}

enum PayMode {
    case undefined
    case cash
    case card
    case online
}

struct ReceiptData {
    let type: ReceiptType
    var payMode: PayMode = .undefined
    let number: Int
    let month: Date?
    let paymentDate: Date?
    let amount: Int
}

protocol ReceiptViewCellDelegate {
    func didTapPay(receiptNumber: Int)
    func didTapDownload(receiptNumber: Int)
}

class ReceiptViewCell: UICollectionViewCell {
    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    var delegate: ReceiptViewCellDelegate?

    private var isHeightCalculated: Bool = false
    private var receiptData: ReceiptData?

    private var stackView: UIStackView?
    private let receiptNumberText: SATextView = {
        let textView = SATextView()
        return textView
    }()
    private let monthText: SATextView = {
        let textView = SATextView()
        return textView
    }()
    private let paymentDateText: SATextView = {
        let textView = SATextView()
        return textView
    }()
    private let payModeText: SATextView = {
        let textView = SATextView()
        return textView
    }()
    private let totalAmountText: SATextView = {
        let textView = SATextView()
        return textView
    }()
    private lazy var actionButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = .saButtonBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .sourceSansPro(with: .semiBold, and: 14)
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets.left = 12
        button.tintColor = .white
        return button
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    // MARK: - Public Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }

    func setup(with data: ReceiptData) {
        isHeightCalculated = false
        self.receiptData = data
        receiptNumberText.setup(withTitle: "Receipt No.", andText: "#\(data.number)")
        if let month = data.month {
            let monthFormatter = DateFormatter()
            monthFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            monthText.setup(withTitle: "Month",
                            andText: monthFormatter.string(from: month).capitalized)
        } else {
            monthText.setup(withTitle: "Month",
                            andText: "–")
        }

        if let date = data.paymentDate {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("ddMMMYY")
            paymentDateText.setup(withTitle: "Payment Date",
                                  andText: dateFormatter.string(from: date))
        } else {
            paymentDateText.setup(withTitle: "Payment Date",
                                  andText: "–")
        }
        var payModeString: String = "–"
        switch data.payMode {
            case .cash:
                payModeString = "Cash on Counter"
            case .card:
                payModeString = "Bank Card"
            case .online:
                payModeString = "Onlin"
            default: break
        }
        payModeText.setup(withTitle: "Payment Mode", andText: payModeString)

        let buttonImageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        switch data.type {
            case .notPaid:
                payModeText.isHidden = true
                totalAmountText.setup(withTitle: "Total Pending Amount", andText: "₹\(data.amount)")
                actionButton.setTitle("PAY NOW", for: .normal)
                actionButton.setImage(UIImage(systemName: "arrow.right")?
                    .withRenderingMode(.alwaysTemplate)
                    .withConfiguration(buttonImageConfig),
                                      for: .normal)
            case .paid:
                payModeText.isHidden = false
                totalAmountText.setup(withTitle: "Total Amount", andText: "₹\(data.amount)")
                actionButton.setTitle("DOWNLOAD", for: .normal)
                actionButton.setImage(UIImage(systemName: "square.and.arrow.down")?
                    .withRenderingMode(.alwaysTemplate)
                    .withConfiguration(buttonImageConfig),
                                      for: .normal)
        }
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        var targetSize = targetSize
        targetSize.height = CGFloat.greatestFiniteMagnitude
        let size = super.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        return size
    }
}

// MARK: - BaseViewProtocol
extension ReceiptViewCell: BaseViewProtocol {
    func setupViews() {
        stackView = embedIntoStack([receiptNumberText,
                                    createSeparator(),
                                    monthText,
                                    paymentDateText,
                                    payModeText,
                                    createSeparator(),
                                    totalAmountText],
                                   spacing: 14,
                                   distribution: .fill,
                                   stackAxis: .vertical)
        addView(actionButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        if let stackView = stackView {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                stackView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            ])
        }
    }

    func configureView() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.saHolidayBorderGrey.cgColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}

// MARK: - Button Events
@objc extension ReceiptViewCell {
    func didTapActionButton() {
        guard let receiptData = receiptData else { return }
        switch receiptData.type {
            case .notPaid:
                delegate?.didTapPay(receiptNumber: receiptData.number)
            case .paid:
                delegate?.didTapDownload(receiptNumber: receiptData.number)
        }
    }
}
