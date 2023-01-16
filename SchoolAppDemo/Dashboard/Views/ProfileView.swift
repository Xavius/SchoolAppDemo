//
//  ProfileView.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

struct ProfileViewData {
    var profileIcon: UIImage?
    var userName: String
    var studentClass: String
    var studentRoll: String
    var aadharNo: String
    var academicYear: String
    var admissionClass: String
    var oldAdmissionNo: String
    var dateOfAdmission: String
    var dateOfBirth: String
    var parentEmail: String
    var motherName: String
    var fatherName: String
    var permanentAddress: String
}

class ProfileView: BaseView {
    var profileViewData: ProfileViewData?

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset.top = 30
        return scrollView
    }()

    let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 29
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        return contentView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 29
        stackView.layer.cornerRadius = 29
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.backgroundColor = .white
        return stackView
    }()

    let profilePanel: ProfilePanelView = {
        let profilePanel = ProfilePanelView()
        return profilePanel
    }()

    let aadharNo: SATextField = {
        let textField = SATextField(with: "Aadhar No", and: .text)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let academicYear: SATextField = {
        let textField = SATextField(with: "Academic Year", and: .text)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let admissionClass: SATextField = {
        let textField = SATextField(with: "Admission Class", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let oldAdmissionNo: SATextField = {
        let textField = SATextField(with: "Old Admission No", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let dateOfAdmission: SATextField = {
        let textField = SATextField(with: "Date of Admission", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let dateOfBirth: SATextField = {
        let textField = SATextField(with: "Date of Birth", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let parentEmail: SATextField = {
        let textField = SATextField(with: "Parent Mail ID", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let motherName: SATextField = {
        let textField = SATextField(with: "Mother Name", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let fatherName: SATextField = {
        let textField = SATextField(with: "Father Name", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()
    let permanentAddress: SATextField = {
        let textField = SATextField(with: "Permanent Add.", and: .readonly)
        textField.textField.font = .sourceSansPro(with: .semiBold, and: 16)
        return textField
    }()

    func setup(with data: ProfileViewData?) {
        guard let data = data else { return }
        profileViewData = data
        let profilePanelData = ProfilePanelViewData(profileIcon: data.profileIcon,
                                                    userName: data.userName,
                                                    studentClass: data.studentClass,
                                                    studentRoll: data.studentRoll)
        profilePanel.setup(with: profilePanelData)
        aadharNo.textField.text = data.aadharNo
        academicYear.textField.text = data.academicYear
        admissionClass.textField.text = data.admissionClass
        oldAdmissionNo.textField.text = data.oldAdmissionNo
        dateOfAdmission.textField.text = data.dateOfAdmission
        dateOfBirth.textField.text = data.dateOfBirth
        parentEmail.textField.text = data.parentEmail
        motherName.textField.text = data.motherName
        fatherName.textField.text = data.fatherName
        permanentAddress.textField.text = data.permanentAddress
    }

    func setChoseImageTarget(action: Selector, target: Any?) {
        profilePanel.setChoseImageTarget(action: action, target: target)
    }

    func getUpdatedProfileViewData() -> ProfileViewData? {
        profileViewData?.aadharNo = aadharNo.textField.text ?? ""
        profileViewData?.academicYear = academicYear.textField.text ?? ""
        return profileViewData
    }
}

// MARK: - BaseViewProtocol
extension ProfileView {
    override func setupViews() {
        super.setupViews()
        addView(contentView)
        addView(profilePanel)
        addView(scrollView)
        scrollView.addView(stackView)
        stackView.embedIntoStack([aadharNo, academicYear], spacing: 20, distribution: .fillEqually)
        stackView.embedIntoStack([admissionClass, oldAdmissionNo], spacing: 20, distribution: .fillEqually)
        stackView.embedIntoStack([dateOfAdmission, dateOfBirth], spacing: 20, distribution: .fillEqually)
        stackView.addArrangedSubview(parentEmail)
        stackView.addArrangedSubview(motherName)
        stackView.addArrangedSubview(fatherName)
        stackView.addArrangedSubview(permanentAddress)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            profilePanel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            profilePanel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profilePanel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

            scrollView.topAnchor.constraint(equalTo: profilePanel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -17),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -33),

        ])
    }

    override func configureView() {
        super.configureView()
    }
}
