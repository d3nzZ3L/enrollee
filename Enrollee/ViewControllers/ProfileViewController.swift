//
//  ProfileViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var greetingsLabel: UILabel!
    let profileService = ProfileService.shared
    
    var titles = ["Добавить данные", "Редактировать данные", "Написать письмо", "Позвонить", "Выход"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        if let profile = profileService.profile {
            greetingsLabel.text = "Здравствуйте, " + profile.getFullname()
        } else {
            profileService.getObjectIfNecessary()
        }
        greetingsLabel.text = "Здравствуйте, " + profileService.profile.getFullname()
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.menuItem, for: indexPath)!
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            guard let vc = R.storyboard.addInfo().instantiateInitialViewController() as? AddInfoViewController else {
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            guard let vc = R.storyboard.editInfo().instantiateInitialViewController() as? EditInfoViewController else {
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let url = URL(string: "mailto://pk@volpi.ru")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            break
        case 3:
            let url = URL(string: "telprompt://78443252592")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        case 4:
            TokenService.shared.token = nil
            guard let vc = R.storyboard.main().instantiateInitialViewController() else {
                return
            }
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
}
