//
//  StartViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet var regButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    let token = TokenService.shared.token
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        regButton.circularCorners()
        loginButton.circularCorners()
        if token != nil {
            guard let selfVC = UIApplication.shared.windows.first?.rootViewController else {
                return
            }
            guard let vc = R.storyboard.tabBar.tabBarVC() else {
                return
            }
            selfVC.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func regButtonTapped(_ sender: Any) {
        guard let vc = R.storyboard.registration().instantiateInitialViewController() else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let vc = R.storyboard.login().instantiateInitialViewController() else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
