//
//  DepartmentsViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 20.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import RealmSwift

protocol DepartmentsViewControllerDelegate: class {
    func selected(department: Department)
}

class DepartmentsViewController: UIViewController {
    var tableView: UITableView!
    var dummyService = DummyService.shared
    var departments: Results<Department>? {
        didSet {
            notificationToken?.invalidate()
            notificationToken = departments?.observe({ [weak self] (changes) in
                guard let tableView = self?.tableView else { return }
                tableView.reloadData()
            })
        }
    }
    var notificationToken: NotificationToken!
    weak var delegate: DepartmentsViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Выберите факультет"
        tableView = UITableView(frame: view.frame)
        tableView.clipsToBounds = true
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: R.reuseIdentifier.menuItem.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        departments = dummyService.departments
    }
}

extension DepartmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let department = departments?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.menuItem, for: indexPath)!
        cell.textLabel?.text = department.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let department = departments?[indexPath.row] else {
            return
        }
        delegate?.selected(department: department)
        navigationController?.popViewController(animated: true)
    }
}

