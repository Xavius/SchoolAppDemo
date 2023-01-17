//
//  FeesFactory.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 16.01.2023.
//

import UIKit

enum FeesFactory {
    static func createFeesController() -> FeesViewController {
        let vc = FeesViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
