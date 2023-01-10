//
//  ProfileViewController.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 01.01.2023.
//

import UIKit

enum ProfileAction {
    case commitChanges
}

class ProfileViewController: BaseViewController, FlowController {

    let profileView = ProfileView()

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

        view.addView(doneButton)
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
        profileView.configureView()
        profileView.setChoseImageTarget(action: #selector(didTappedPickImageButton), target: self)
        doneButton.setup(name: "Done", action: #selector(didTappedDoneButton), target: self)
    }
}

@objc extension ProfileViewController {
    func didTappedDoneButton() {
        if verifyFields() {
            self.completionHandler?(.commitChanges)
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
        profileView.setProfileImage(image: image)
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
