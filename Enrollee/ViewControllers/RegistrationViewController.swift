//
//  RegistrationViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import SVProgressHUD
import PhoneNumberKit

class RegistrationViewController: UIViewController {
    @IBOutlet var regButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet var passHighlightView: UIView!
    @IBOutlet var emailHighlitghView: UIView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regButton.circularCorners()
        regButton.isEnabled = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func registration(_ sender: Any) {
        SVProgressHUD.show()
        if (emailTextField.text != "" && passTextField.text != "") {
            SVProgressHUD.dismiss()
            guard let email = emailTextField.text, let password = passTextField.text, let name = firstNameTextField.text, let lastname = lastNameTextField.text, let phone = phoneNumberTextField.text
                else {
                return
            }
            TokenService.shared.token = "123"
            let profile = Profile()
            profile.email = email
            profile.password = password
            profile.firstname = name
            profile.lastname = lastname
            profile.phone = phone
            ProfileService.shared.saveProfile(profile: profile)
            guard let vc = R.storyboard.tabBar.tabBarVC() else {
                return
            }
            present(vc, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "Поля не заполнены!")
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            regButton.isEnabled = true
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === emailTextField {
            emailHighlitghView.setGradientForBackground(firstColor: .neonBlue, secondColor: .electricPurple, type: .HorizontalGradient)
        } else {
            passHighlightView.setGradientForBackground(firstColor: .neonBlue, secondColor: .electricPurple, type: .HorizontalGradient)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text == "" {
            emailHighlitghView.setGradientForBackground(firstColor: .red, secondColor: .red, type: .HorizontalGradient)
        } else if passTextField.text == "" {
            passHighlightView.setGradientForBackground(firstColor: .red, secondColor: .red, type: .HorizontalGradient)
        }
    }
}
