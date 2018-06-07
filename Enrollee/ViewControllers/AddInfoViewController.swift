//
//  AddInfoViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import SVProgressHUD

class AddInfoViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var examsView: UIView!
    @IBOutlet var examsTableView: UITableView!
    @IBOutlet var examsTableViewHeightConstraint: NSLayoutConstraint!
    
    let dummyService = DummyService.shared
    let profileService = ProfileService.shared
    var titles = ["Место учебы", "Факультет поступления", "Направление поступления"]
    var selectedSchool: School!
    var selectedDepartment: Department!
    var selectedCourse: Course!
    var selectedExams = [Exam]()
    var isChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(R.nib.addItemTableViewCell)
        examsView.isHidden = true
        examsTableView.tableFooterView = UIView()
        examsTableView.register(UITableViewCell.self, forCellReuseIdentifier: R.reuseIdentifier.menuItem.identifier)
        examsTableView.register(UITableViewCell.self, forCellReuseIdentifier: R.reuseIdentifier.addInfoItem.identifier)
        let saveBarButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save(_:)))
        navigationItem.setRightBarButton(saveBarButton, animated: false)
    }
    
    @IBAction func addExam(_ sender: Any) {
        let exams = dummyService.exams
        guard let examsForPicker = exams?.sorted(by: { $0.id > $1.id }).map({ (exam) -> String in
            return exam.title
        }) else {
            return
        }
        StringPickerPopover.init(title: "Выберите экзамен", choices: examsForPicker).setDoneButton(title: "Готово", color: UIColor.neonBlue) { [weak self] (type, selectedRow, selectedString) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.examsView.isHidden = false
            guard let selectedExam = exams?.sorted(by: { $0.id > $1.id })[selectedRow] else {
                return
            }
            let isContain = strongSelf.selectedExams.contains(where: { (exam) -> Bool in
                if selectedExam.title == exam.title {
                    return true
                }
                return false
            })
            if !isContain {
                strongSelf.selectedExams.append(selectedExam)
                strongSelf.examsTableView.reloadData()
            }
            }.setCancelButton(action: { (_, _, _) in print("cancel") }).appear(originView: sender as! UIButton, baseViewController: self)
    }
    
    @objc func save(_ sender: Any) {
        if let selectedSchool = selectedSchool {
            profileService.saveSchool(selectedSchool)
            isChanged = true
        }
        if let selectedDepartment = selectedDepartment {
            profileService.saveDepartment(selectedDepartment)
            isChanged = true
        }
        if let selectedCourse = selectedCourse {
            profileService.saveCourse(selectedCourse)
            isChanged = true
        }
        if selectedExams.count > 0 {
            profileService.saveExams(selectedExams)
            isChanged = true
        }
        if isChanged {
            SVProgressHUD.showSuccess(withStatus: "Сохранено")
        }
        navigationController?.popViewController(animated: true)
    }
}

extension AddInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == examsTableView {
            return selectedExams.count 
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case examsTableView:
            let exam = selectedExams[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.menuItem, for: indexPath)!
            cell.textLabel?.text = exam.title
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.addInfoItem, for: indexPath)!
                cell.configure(title: titles[indexPath.row], value: nil)
                if let selectedSchool = selectedSchool {
                    cell.configure(title: titles[indexPath.row], value: selectedSchool.name)
                }
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.addInfoItem, for: indexPath)!
                cell.configure(title: titles[indexPath.row], value: nil)
                if let selectedDepartment = selectedDepartment {
                    cell.configure(title: titles[indexPath.row], value: selectedDepartment.name)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.addInfoItem, for: indexPath)!
                cell.configure(title: titles[indexPath.row], value: nil)
                if let selectedCourse = selectedCourse {
                    cell.configure(title: titles[indexPath.row], value: selectedCourse.name)
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView {
        case self.tableView:
            if indexPath.row == 0 {
                let vc = SchoolViewController(nibName: nil, bundle: nil)
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = DepartmentsViewController(nibName: nil, bundle: nil)
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = CoursesViewController(nibName: nil, bundle: nil)
                vc.delegate = self
                if let selectedDepartment = selectedDepartment {
                    vc.selectedDepartment = selectedDepartment
                }
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.selectedExams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension AddInfoViewController: SchoolsViewControllerDelegate, DepartmentsViewControllerDelegate, CoursesViewControllerDelegate {
    func selected(school: School) {
        selectedSchool = school
        tableView.reloadData()
    }
    
    func selected(department: Department) {
        selectedDepartment = department
        tableView.reloadData()
    }
    
    func selected(course: Course) {
        selectedCourse = course
        tableView.reloadData()
    }
}
