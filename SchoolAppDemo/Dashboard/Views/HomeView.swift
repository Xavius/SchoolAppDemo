//
//  HomeView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 31.12.2022.
//

import UIKit

//extension UICollectionView {
//    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        super.hitTest(point, with: event)
//    }
//}

class HomeView: BaseView {
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()

    let userGreeting: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 30)
        label.text = "Hi Akshay"
        label.textColor = .white
        return label
    }()

    let studentClassAndRoll: UILabel = {
        let label = UILabel()
        label.font = .sourceSansPro(with: .regular, and: 18)
        label.text = "Class XI-B  |  Roll no: 04"
        label.textColor = .white.withAlphaComponent(0.61)
        return label
    }()

    let academicYear: PaddingLabel = {
        let label = PaddingLabel(withInsets: 3, 3, 12, 11)
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 12
        label.font = .sourceSansPro(with: .regular, and: 14)
        label.text = "2020-2021"
        label.textColor = #colorLiteral(red: 0.3437130451, green: 0.5173668265, blue: 0.8019610047, alpha: 1)
        return label
    }()

    let profileButton: ProfileButton = {
        let button = ProfileButton(type: .system)
        return button
    }()

    let menuItemsView: SACollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let view = SACollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.isExclusiveTouch = false
        view.backgroundColor = .clear
        return view
    }()

    func addProfileAction(_ action: Selector, with target: Any?) {
        profileButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func setupMenuItems(with dataSource: UICollectionViewDataSource?, and delegate: UICollectionViewDelegate?) {
        menuItemsView.dataSource = dataSource
        menuItemsView.delegate = delegate
    }

    func resetScroll() {
        menuItemsView.contentOffset.y = -(menuItemsView.contentInset.top + menuItemsView.safeAreaInsets.top)
    }
}

extension HomeView {
    override func setupViews() {
        super.setupViews()
        addView(contentView)
        addView(userGreeting)
        addView(studentClassAndRoll)
        addView(academicYear)

        addView(profileButton)
        profileButton.configure(with: .backgroundSplash)

        addView(menuItemsView)
        menuItemsView.register(HomeMenuEntryCell.self,
                               forCellWithReuseIdentifier: HomeMenuEntryCell.identifier)
        menuItemsView.register(HomeMenuMandatoryEntryCell.self,
                               forCellWithReuseIdentifier: HomeMenuMandatoryEntryCell.identifier)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 252),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            userGreeting.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            userGreeting.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            studentClassAndRoll.topAnchor.constraint(equalTo: userGreeting.bottomAnchor, constant: 9),
            studentClassAndRoll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            academicYear.topAnchor.constraint(equalTo: studentClassAndRoll.bottomAnchor, constant: 10),
            academicYear.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            profileButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 45),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileButton.widthAnchor.constraint(equalToConstant: 62),
            profileButton.heightAnchor.constraint(equalTo: profileButton.widthAnchor),

            menuItemsView.topAnchor.constraint(equalTo: topAnchor),
            menuItemsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuItemsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            menuItemsView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func configureView() {
        super.configureView()
        menuItemsView.contentInset.top = 160
        menuItemsView.showsVerticalScrollIndicator = false
        menuItemsView.reloadData()
    }
}
