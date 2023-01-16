//
//  HomeViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

enum DashboardAction {
    case showProfile
    case showAttendance
    case showFees
    case showQuiz
    case showAssignment
    case showHoliday
    case showCalendar
    case showResults
    case showDateSheet
    case showDoubts
    case showGallery
    case showChangePass
    case showEvents
    case logout
}

class HomeViewController: BaseViewController, FlowController {
    // MARK: - Properties
    var isLoggedIn: Bool = false
    let homeView = HomeView()
    var menuItems: [MenuItemData] = []
    var completionHandler: ((DashboardAction?) -> ())?

    // MARK: - Public Methods
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }

    // MARK: - Private Methods
    private func leaveApplication() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }
    }
}

// MARK: - BaseViewProtocol
extension HomeViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(homeView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    override func configureView() {
        super.configureView()
        menuItems = [
            MenuItemData(icon: .menuAttendance, title: "80.39%", subTitle: "Attendance") { [weak self] in
                self?.completionHandler?(.showAttendance)
            },
            MenuItemData(icon: .menuFees, title: "₹6400", subTitle: "Fees Due") { [weak self] in
                self?.completionHandler?(.showFees)
            },
            MenuItemData(icon: .menuQuiz, title: "Play Quiz") { [weak self] in
                self?.completionHandler?(.showQuiz)
            },
            MenuItemData(icon: .menuAssignment, title: "Assignment") { [weak self] in
                self?.completionHandler?(.showAssignment)
            },
            MenuItemData(icon: .menuHoliday, title: "School Holiday") { [weak self] in
                self?.completionHandler?(.showHoliday)
            },
            MenuItemData(icon: .menuCalendar, title: "Time Table") { [weak self] in
                self?.completionHandler?(.showCalendar)
            },
            MenuItemData(icon: .menuResults, title: "Result") { [weak self] in
                self?.completionHandler?(.showResults)
            },
            MenuItemData(icon: .menuDateSheet, title: "Date Sheet") { [weak self] in
                self?.completionHandler?(.showDateSheet)
            },
            MenuItemData(icon: .menuDoubts, title: "Ask Doubts") { [weak self] in
                self?.completionHandler?(.showDoubts)
            },
            MenuItemData(icon: .menuGallery, title: "School Gallery") { [weak self] in
                self?.completionHandler?(.showGallery)
            },
            MenuItemData(icon: .menuLeaveApp, title: "Leave Application") { [weak self] in
                self?.leaveApplication()
            },
            MenuItemData(icon: .menuChangePass, title: "Change Password") { [weak self] in
                self?.completionHandler?(.showChangePass)
            },
            MenuItemData(icon: .menuEvents, title: "Events") { [weak self] in
                self?.completionHandler?(.showEvents)
            },
            MenuItemData(icon: .menuLogout, title: "Logout") { [weak self] in
                self?.completionHandler?(.logout)
            },
        ]
        homeView.setupMenuItems(with: self, and: self)
        homeView.addProfileAction(#selector(didTappedProfileButton), with: self)
    }
}

// MARK: - Button Events
@objc extension HomeViewController {
    func didTappedProfileButton() {
        self.completionHandler?(.showProfile)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var resultCell: UICollectionViewCell?
        let data = menuItems[indexPath.row]
        if data.itemType == .mandatory {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuMandatoryEntryCell.identifier,
                                                          for: indexPath) as! HomeMenuMandatoryEntryCell
            cell.setup(with: data)
            resultCell = cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuEntryCell.identifier,
                                                          for: indexPath) as! HomeMenuEntryCell
            cell.setup(with: data)
            resultCell = cell
        }

        return resultCell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    private enum LayoutConstant {
        static let spacing: CGFloat = 17
        static let heightCommonMultiplier: CGFloat = 0.81
        static let heightMandatoryMultiplier: CGFloat = 1.24
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = menuItems[indexPath.row]
        data.tapAction()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = menuItems[indexPath.row]
        let width = itemWidth(for: collectionView.frame.width, spacing: LayoutConstant.spacing)
        return CGSize(width: width,
                      height: width * (data.itemType == .mandatory ? LayoutConstant.heightMandatoryMultiplier : LayoutConstant.heightCommonMultiplier))
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return finalWidth
    }
}
