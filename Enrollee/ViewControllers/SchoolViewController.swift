//
//  SchoolViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol SchoolsViewControllerDelegate: class {
    func selected(school: School)
}

class SchoolViewController: UIViewController {
    var tableView: UITableView!
    var dummyService = DummyService.shared
    var schools: Results<School>? {
        didSet {
            notificationToken?.invalidate()
            notificationToken = schools?.observe({ [weak self] (changes) in
                guard let tableView = self?.tableView else { return }
                tableView.reloadData()
            })
        }
    }
    var notificationToken: NotificationToken!
    weak var delegate: SchoolsViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Выберите школу"
        tableView = UITableView(frame: view.frame)
        tableView.clipsToBounds = true
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: R.reuseIdentifier.menuItem.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        schools = dummyService.schools
    }
}

extension SchoolViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let school = schools?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.menuItem, for: indexPath)!
        cell.textLabel?.text = school.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let school = schools?[indexPath.row] else {
            return
        }
        delegate?.selected(school: school)
        navigationController?.popViewController(animated: true)
    }
}
