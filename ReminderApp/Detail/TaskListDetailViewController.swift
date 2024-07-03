//
//  taskListDetailViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift
import Toast

final class TaskListDetailViewController: BaseViewController {
    
    let realm = try! Realm()
    var addedTaskList: Results<TaskTable>!
    var receivedTitleLabel = ""
    
    private var navPullDownBtn: UIBarButtonItem!
    private var navBackBtn: UIBarButtonItem!
    
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBackBtn()
        setupNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListDetailVCTableViewCell.self, forCellReuseIdentifier: TaskListDetailVCTableViewCell.identifier)
        print(addedTaskList.count)
        
        print(realm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func configHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    override func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        
        titleLabel.text = receivedTitleLabel
        titleLabel.font = Font.heavy30
        titleLabel.textColor = Color.orange
        tableView.rowHeight = 120
        
    }
}

extension TaskListDetailViewController {
    
    func setupNavigationBar() {
        
        // 꾹 눌러야 실행됨! showsasprimaryaction 불가능. todo
        navPullDownBtn = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(dropDownNavBtnTapped))
        
     
        let dueDateOrderFilter = UIAction(title: "마감임박순") { _ in
            print("마감임박")
            self.addedTaskList = self.realm.objects(TaskTable.self).sorted(byKeyPath: "dueDate", ascending: true)
            self.tableView.reloadData()
        }
        
        let titleOrderFilter = UIAction(title: "제목순") { _ in
            print("제목순")
            self.addedTaskList = self.realm.objects(TaskTable.self).sorted(byKeyPath: "taskTitle", ascending: true)
            self.tableView.reloadData()
        }
        
        let lowPriorityOnlyFilter = UIAction(title: "우선순위 낮음만") { _ in
            print("우선순위낮음만")
            self.addedTaskList = self.realm.objects(TaskTable.self).where{
                $0.priorityCheck == "낮음"
            }.sorted(byKeyPath: "taskTitle", ascending: true)
            self.tableView.reloadData()
        }
        
        let menu = UIMenu(title: "필터 옵션", options: .displayInline, children: [dueDateOrderFilter,titleOrderFilter,lowPriorityOnlyFilter])
        
        navPullDownBtn.menu = menu
      //  navPullDownBtn.showsMenuAsPrimaryAction = true
    
        navigationItem.rightBarButtonItem = navPullDownBtn
    }
        
   
    
    @objc func dropDownNavBtnTapped() {
        
        
    }
    
    private func setupNavBackBtn() {
        
        navBackBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(navBackBtnTapped))
        
        navigationItem.leftBarButtonItem = navBackBtn
        
    }
    
    @objc func navBackBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged() {
        
    }
}

extension TaskListDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(addedTaskList.count)
        return addedTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListDetailVCTableViewCell.identifier, for: indexPath) as! TaskListDetailVCTableViewCell
        
        cell.configUI(data: addedTaskList[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteCell = UIContextualAction(style: .destructive, title: "삭제") { delete, view, completionHandler in
            
            try! self.realm.write{
                self.realm.delete(self.addedTaskList[indexPath.item])
                print("삭제완료")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        let markFlagCell = UIContextualAction(style: .normal, title: "깃발") { markFlag, view, completionHander in
            
            try! self.realm.write{
                let task = self.addedTaskList[indexPath.row]
                task.flagMarked.toggle()
                tableView.reloadData()
            }
            self.view.makeToast("깃발 설정이 변경되었습니다")
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completionHander(true)
        }
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteCell, markFlagCell])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = TaskDetailViewController()
            
            vc.list = addedTaskList[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    
}
