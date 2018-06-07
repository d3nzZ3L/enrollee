//
//  LoginViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 21.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var authButton: UIButton!
    
    let profileService = ProfileService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        authButton.circularCorners()
    }
    
    @IBAction func authorize(_ sender: Any) {
        guard let email = emailTextField.text, let pass = passTextField.text else {
            SVProgressHUD.showError(withStatus: "Ошибка, введите email/пароль")
            return
        }
        if profileService.profile.email == email && profileService.profile.password == pass {
            TokenService.shared.token = "123"
            guard let vc = R.storyboard.tabBar.tabBarVC() else {
                return
            }
            present(vc, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "Неправильный email или пароль")
        }
    }
}
