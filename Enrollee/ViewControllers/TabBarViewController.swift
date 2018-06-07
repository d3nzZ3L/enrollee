//
//  TabBarViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: false)
        // Do any additional setup after loading the view.
    }

}
