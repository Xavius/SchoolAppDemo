//
//  SAPageViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 12.01.2023.
//

import UIKit

class SAPageViewController: UIPageViewController {
    private var controllers: [BaseViewController] = []
    private lazy var segmentedControlTitles: [String] = {
        self.controllers.map { $0.title ?? String(describing: $0) }
    }()
    private lazy var segmentedControl: SASegmentedControl = {
        let control = SASegmentedControl(withItems: self.segmentedControlTitles,
                                         andSelectedIndex: self.currentPageIndex)
        return control
    }()

    let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 29
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        return contentView
    }()

    let decorView: UIImageView = {
        let imageView = UIImageView(image: .attendanceDecor)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var currentPageIndex: Int = 0

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        segmentedControl.addTarget(self, action: #selector(didSwitchController), for: .valueChanged)
        navigationItem.titleView = segmentedControl

        configureView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationItem.titleView = nil
        super.viewDidDisappear(animated)
    }

    func setup(withControllers controllers: [BaseViewController], currentIndex index: Int) {
        self.controllers = controllers
        self.currentPageIndex = index
        self.delegate = self
        setViewControllers([self.controllers[currentPageIndex]],
                           direction: .forward,
                           animated: true)
    }
}

@objc extension SAPageViewController: BaseViewProtocol {
    func setupViews() {
        view.addView(decorView)
        view.sendSubviewToBack(decorView)
        view.addView(contentView)
        view.sendSubviewToBack(contentView)
        view.setBackgroundImage(with: .backgroundSplash)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            decorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            decorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            decorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    func configureView() {}
}

extension SAPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.currentPageIndex = segmentedControl.selectedIndex
    }
}

@objc extension SAPageViewController {
    func didSwitchController() {
        let newPageIndex = segmentedControl.selectedIndex
        setViewControllers([self.controllers[newPageIndex]],
                           direction: newPageIndex > currentPageIndex ? .forward : .reverse,
                           animated: true)
    }
}
