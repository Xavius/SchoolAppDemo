//
//  FeesView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

class FeesView: BaseView {
    // MARK: - Properties
    var receipts: [ReceiptData] = []
    var cellDelegate: ReceiptViewCellDelegate?
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 30
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        return contentView
    }()
    private lazy var receiptList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ReceiptViewCell.self,
                      forCellWithReuseIdentifier: ReceiptViewCell.identifier)
        view.dataSource = self
        view.backgroundColor = .clear
        view.allowsSelection = false
        view.showsVerticalScrollIndicator = false
        view.contentInset.top = 42
        return view
    }()

    // MARK: - Public Methods
    func setup(with data: [ReceiptData], and delegate: ReceiptViewCellDelegate) {
        self.receipts = data
        self.cellDelegate = delegate
        receiptList.reloadData()
    }
}

// MARK: - BaseViewProtocol
extension FeesView {
    override func setupViews() {
        super.setupViews()
        addView(contentView)
        addView(receiptList)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            receiptList.topAnchor.constraint(equalTo: topAnchor),
            receiptList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            receiptList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            receiptList.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
        let layout = receiptList.collectionViewLayout
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(
                width: receiptList.widestCellWidth,
                height: 100
            )
            flowLayout.minimumLineSpacing = 16
        }
        receiptList.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension FeesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return receipts.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceiptViewCell.identifier,
                                                      for: indexPath) as! ReceiptViewCell
        let receipt = receipts[indexPath.item]
        cell.delegate = self.cellDelegate
        cell.setup(with: receipt)
        return cell
    }
}
