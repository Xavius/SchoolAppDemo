//
//  HomeViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class HomeViewController: BaseViewController {
    weak var loginViewController: LoginViewController?
    weak var profileViewController: ProfileViewController?
    var isLoggedIn: Bool = false
    let homeView = HomeView()
    var menuItems: [MenuItemData] = []

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        if let loginVC = loginViewController {
            isLoggedIn = loginVC.isLoggedIn
        }
        if !isLoggedIn {
            openLoginView()
            return
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
}

extension HomeViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(homeView)
        homeView.setupViews()
    }
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        homeView.setupConstraints()
    }
    override func configureView() {
        super.configureView()
        menuItems = [
            MenuItemData(icon: .menuAttendance, title: "80.39%", subTitle: "Attendance") {
                // TODO: Open Attendance
            },
            MenuItemData(icon: .menuFees, title: "₹6400", subTitle: "Fees Due") {
                // TODO: Open Fees
            },
            MenuItemData(icon: .menuQuiz, title: "Play Quiz") {
                self.openQuiz()
            },
            MenuItemData(icon: .menuAssignment, title: "Assignment") {
                self.openAssignment()
            },
            MenuItemData(icon: .menuHoliday, title: "School Holiday") {
                self.openHoliday()
            },
            MenuItemData(icon: .menuCalendar, title: "Time Table") {
                self.openCalendar()
            },
            MenuItemData(icon: .menuResults, title: "Result") {
                self.openResults()
            },
            MenuItemData(icon: .menuDateSheet, title: "Date Sheet") {
                self.openDateSheet()
            },
            MenuItemData(icon: .menuDoubts, title: "Ask Doubts") {
                self.openDoubts()
            },
            MenuItemData(icon: .menuGallery, title: "School Gallery") {
                self.openGallery()
            },
            MenuItemData(icon: .menuLeaveApp, title: "Leave Application") {
                self.leaveApplication()
            },
            MenuItemData(icon: .menuChangePass, title: "Change Password") {
                self.openChangePassword()
            },
            MenuItemData(icon: .menuEvents, title: "Events") {
                self.openEvents()
            },
            MenuItemData(icon: .menuLogout, title: "Logout") {
                self.logoutApp()
            },
        ]
        homeView.setupMenuItems(with: self, and: self)
        homeView.addProfileAction(#selector(didTappedProfileButton), with: self)
        homeView.configureView()
    }
}

@objc extension HomeViewController {
    func didTappedProfileButton() {
        openProfileView()
    }
}

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

extension HomeViewController {
    @discardableResult func createAndPushController<VC: BaseViewController>(_ animated: Bool = true) -> VC {
        let vc = VC()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: animated)
        return vc
    }

    func openLoginView() {
        if let loginVC = loginViewController {
            navigationController?.pushViewController(loginVC, animated: false)
        } else {
            loginViewController = createAndPushController(false) as LoginViewController
        }
    }

    func openProfileView() {
        setupNavBarBackButton(with: "My Profile")
        if let profileVC = profileViewController {
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            profileViewController = createAndPushController() as ProfileViewController
        }
    }

    func openQuiz() {
        setupNavBarBackButton(with: "Play Quiz")
        createAndPushController()
    }

    func openAssignment() {
        setupNavBarBackButton(with: "Assignment")
        createAndPushController()
    }

    func openHoliday() {
        setupNavBarBackButton()
        createAndPushController()
    }

    func openCalendar() {
        setupNavBarBackButton(with: "Timetable")
        createAndPushController()
    }

    func openResults() {
        setupNavBarBackButton()
        createAndPushController()
    }

    func openDateSheet() {
        setupNavBarBackButton(with: "Datesheet")
        createAndPushController()
    }

    func openDoubts() {
        setupNavBarBackButton(with: "Ask Doubt")
        createAndPushController()
    }

    func openGallery() {
        setupNavBarBackButton(with: "School Gallery")
        createAndPushController()
    }

    func openChangePassword() {
        setupNavBarBackButton(with: "Change Password")
        createAndPushController()
    }

    func openEvents() {
        setupNavBarBackButton(with: "Events & Programs")
        createAndPushController()
    }

    func logoutApp() {
        isLoggedIn = false
        homeView.resetScroll()
        openLoginView()
    }

    func leaveApplication() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }
    }
}
