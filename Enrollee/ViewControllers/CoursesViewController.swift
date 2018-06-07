//
//  CoursesViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 20.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import RealmSwift

protocol CoursesViewControllerDelegate: class {
    func selected(course: Course)
}

class CoursesViewController: UIViewController {
    var tableView: UITableView!
    var dummyService = DummyService.shared
    var courses: Results<Course>? {
        didSet {
            notificationToken?.invalidate()
            notificationToken = courses?.observe({ [weak self] (changes) in
                guard let tableView = self?.tableView else { return }
                tableView.reloadData()
            })
        }
    }
    var notificationToken: NotificationToken!
    var selectedDepartment: Department!
    weak var delegate: CoursesViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Выберите направление"
        tableView = UITableView(frame: view.frame)
        tableView.clipsToBounds = true
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: R.reuseIdentifier.menuItem.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        if let selectedDep = selectedDepartment {
            let predicate = NSPredicate(format: "departmentId == %@", NSNumber(integerLiteral: selectedDep.id))
            courses = dummyService.courses.filter(predicate)
        } else {
            courses = dummyService.courses
        }
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let course = courses?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.menuItem, for: indexPath)!
        cell.textLabel?.text = course.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let course = courses?[indexPath.row] else {
            return
        }
        delegate?.selected(course: course)
        navigationController?.popViewController(animated: true)
    }
}
