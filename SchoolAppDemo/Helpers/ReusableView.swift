//
//  ReusableView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 02.01.2023.
//

import Foundation

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}
