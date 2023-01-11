//
//  ProfileViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

enum ProfileAction {
    case commitChanges(data: ProfileViewData?)
}

class ProfileViewController: BaseViewController, FlowController {

    let profileView = ProfileView()
    var profileViewData: ProfileViewData?

    let doneButton: SANavBarButton = {
        let button = SANavBarButton()
        return button
    }()

    var completionHandler: ((ProfileAction?) -> ())?

    func verifyFields() -> Bool {
        // TODO: Implements fields validation
        return true
    }

}

extension ProfileViewController {
    override func setupViews() {
        super.setupViews()
        view.addView(profileView)
        profileView.setupViews()

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        profileView.setupConstraints()
    }
    override func configureView() {
        super.configureView()
        profileViewData = ProfileViewData(profileIcon: nil,
                                          userName: "Akshay Syal",
                                          studentClass: "XI-B",
                                          studentRoll: "04",
                                          aadharNo: "1234 4325 4567 1234",
                                          academicYear: "2020-2021",
                                          admissionClass: "VI",
                                          oldAdmissionNo: "T00221",
                                          dateOfAdmission: "01 Apr 2018",
                                          dateOfBirth: "22 July 1996",
                                          parentEmail: "parentboth84@gmail.com",
                                          motherName: "Monica Larson",
                                          fatherName: "Bernard Taylor",
                                          permanentAddress: "Karol Bagh, Delhi")
        profileView.configureView()
        profileView.setup(with: profileViewData)
        profileView.setChoseImageTarget(action: #selector(didTappedPickImageButton), target: self)
        doneButton.setup(name: "Done", action: #selector(didTappedDoneButton), target: self)
    }
}

@objc extension ProfileViewController {
    func didTappedDoneButton() {
        if verifyFields() {
            self.completionHandler?(.commitChanges(data: profileViewData))
        } else {
            print("Fields validation error!")
        }
    }

    func didTappedPickImageButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.mediaTypes = ["public.image"]
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true)
    }

    func didSelectProfileImage(image: UIImage?) {
        guard let image = image else { return }
        profileViewData?.profileIcon = image
        profileView.setup(with: profileViewData)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.didSelectProfileImage(image: image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}
