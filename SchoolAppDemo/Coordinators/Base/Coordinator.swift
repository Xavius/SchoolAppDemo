//
//  Coordinator.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 07.01.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var flowCompletionHandler: Handler? { get set }

    func start()
}

extension Coordinator {
    typealias Handler = () -> ()
}
