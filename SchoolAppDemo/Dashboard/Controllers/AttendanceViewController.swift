//
//  AttendanceViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

class AttendanceViewController: BaseViewController {
    let items = ["Attendance", "Holiday"]
    lazy var segmentedControl: SASegmentedControl = {
        let control = SASegmentedControl(withItems: items)
        return control
    }()
}

extension AttendanceViewController {
    override func setupViews() {
        super.setupViews()

        segmentedControl.addTarget(self, action: #selector(didSwitchController), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
}

@objc extension AttendanceViewController {
    func didSwitchController() {
        print("Switching to controller \(items[segmentedControl.selectedIndex])")
    }
}
