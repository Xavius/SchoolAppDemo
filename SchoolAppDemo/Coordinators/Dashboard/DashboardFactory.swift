//
//  DashboardFactory.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

enum DashboardFactory {
    static func createHomeController() -> HomeViewController {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    static func createProfileController() -> ProfileViewController {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    static func createAttendanceController() -> AttendanceViewController {
        let vc = AttendanceViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    static func createFeesController() -> FeesViewController {
        let vc = FeesViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
