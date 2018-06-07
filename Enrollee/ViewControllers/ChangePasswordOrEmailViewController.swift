//
//  ChangePasswordOrEmailViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 21.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChangePasswordOrEmailViewController: UIViewController {
    @IBOutlet var oldValue: UITextField!
    @IBOutlet var oldLabel: UILabel!
    @IBOutlet var newValue: UITextField!
    @IBOutlet var newLabel: UILabel!
    @IBOutlet var repeatNewValue: UITextField!
    @IBOutlet var repeatNewLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    
    let profileService = ProfileService.shared
    var isEmailChanging = false

    override func viewDidLoad() {
        super.viewDidLoad()
        changeButton.circularCorners()
        if !isEmailChanging {
            oldLabel.text = "Старый пароль"
            newLabel.text = "Новый пароль"
            repeatNewLabel.text = "Еще раз"
        } else {
            repeatNewValue.isHidden = true
            repeatNewLabel.isHidden = true
            oldLabel.isHidden = true
            oldValue.isHidden = true
            newLabel.text = "Почта"
        }
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        if isEmailChanging {
            guard let email = newValue.text else {
                return
            }
            profileService.changePassOrEmail(email: email, pass: nil)
        } else {
            guard let oldPass = oldValue.text else {
                return
            }
            if !(oldPass == profileService.profile.password) {
                SVProgressHUD.showError(withStatus: "Старый пароль неверен")
                return
            }
            guard let pass = newValue.text, let repPass = repeatNewValue.text else {
                return
            }
            if pass == repPass {
                profileService.changePassOrEmail(email: nil, pass: pass)
            } else {
                SVProgressHUD.showError(withStatus: "Пароли не совпадают")
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
