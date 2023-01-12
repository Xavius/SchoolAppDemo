//
//  UIImage+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 30.12.2022.
//

import UIKit

extension UIImage {
    static var backgroundSplash: UIImage? {
        UIImage(named: "splash_background")
    }

    static var loginImage: UIImage? {
        UIImage(named: "login_image")
    }

    static var attendanceDecor: UIImage? {
        UIImage(named: "attendance_decor")
    }

    static var menuQuiz: UIImage? {
        UIImage(named: "ic_quiz")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuAssignment: UIImage? {
        UIImage(named: "ic_assignment")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuHoliday: UIImage? {
        UIImage(named: "ic_holiday")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuCalendar: UIImage? {
        UIImage(named: "ic_calendar")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuResults: UIImage? {
        UIImage(named: "ic_results")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuDateSheet: UIImage? {
        UIImage(named: "ic_date_sheet")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuDoubts: UIImage? {
        UIImage(named: "ic_doubts")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuGallery: UIImage? {
        UIImage(named: "ic_gallery")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuLeaveApp: UIImage? {
        UIImage(named: "ic_leave")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuChangePass: UIImage? {
        UIImage(named: "ic_password")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuEvents: UIImage? {
        UIImage(named: "ic_event")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuLogout: UIImage? {
        UIImage(named: "ic_logout")?.withRenderingMode(.alwaysTemplate)
    }

    static var menuAttendance: UIImage? {
        UIImage(named: "ic_attendance")
    }

    static var menuFees: UIImage? {
        UIImage(named: "ic_fees_due")
    }
}
