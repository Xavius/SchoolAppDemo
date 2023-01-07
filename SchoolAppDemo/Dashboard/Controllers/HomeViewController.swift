//
//  HomeViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

class HomeViewController: BaseViewController {
    var isLoggedIn: Bool = false
    let homeView = HomeView()
    var menuItems: [MenuItemData] = []

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        if !(authController()?.isSignedIn ?? false) {
            router()?.showLogin(from: self, animated: true, navBarTitle: nil)
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
                self.router()?.openQuiz(from: self, animated: true, navBarTitle: "Play Quiz")
            },
            MenuItemData(icon: .menuAssignment, title: "Assignment") {
                self.router()?.openAssignment(from: self, animated: true, navBarTitle: "Assignment")
            },
            MenuItemData(icon: .menuHoliday, title: "School Holiday") {
                self.router()?.openHoliday(from: self, animated: true, navBarTitle: "")
            },
            MenuItemData(icon: .menuCalendar, title: "Time Table") {
                self.router()?.openCalendar(from: self, animated: true, navBarTitle: "Timetable")
            },
            MenuItemData(icon: .menuResults, title: "Result") {
                self.router()?.openResults(from: self, animated: true, navBarTitle: "")
            },
            MenuItemData(icon: .menuDateSheet, title: "Date Sheet") {
                self.router()?.openDateSheet(from: self, animated: true, navBarTitle: "Datesheet")
            },
            MenuItemData(icon: .menuDoubts, title: "Ask Doubts") {
                self.router()?.openDoubts(from: self, animated: true, navBarTitle: "Ask Doubt")
            },
            MenuItemData(icon: .menuGallery, title: "School Gallery") {
                self.router()?.openGallery(from: self, animated: true, navBarTitle: "School Gallery")
            },
            MenuItemData(icon: .menuLeaveApp, title: "Leave Application") {
                self.leaveApplication()
            },
            MenuItemData(icon: .menuChangePass, title: "Change Password") {
                self.router()?.openChangePassword(from: self, animated: true, navBarTitle: "Change Password")
            },
            MenuItemData(icon: .menuEvents, title: "Events") {
                self.router()?.openEvents(from: self, animated: true, navBarTitle: "Events & Programs")
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
        router()?.showProfile(from: self, animated: true, navBarTitle: "MyProfile")
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

    func logoutApp() {
        isLoggedIn = false
        homeView.resetScroll()
        authController()?.signOut()
        if !(authController()?.isSignedIn ?? false) {
            router()?.showLogin(from: self, animated: true, navBarTitle: nil)
        }
    }

    func leaveApplication() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        }
    }
}
