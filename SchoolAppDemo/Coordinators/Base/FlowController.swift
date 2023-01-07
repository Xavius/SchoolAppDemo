//
//  FlowController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import Foundation

protocol FlowController {
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
