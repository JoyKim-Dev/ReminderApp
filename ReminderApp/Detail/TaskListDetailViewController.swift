//
//  taskListDetailViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift

final class TaskListDetailViewController: BaseViewController {
    
    let realm = try! Realm()
    var addedTaskList: Results<TaskTable>!
    
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
        
        addedTaskList = realm.objects(TaskTable.self).sorted(byKeyPath: "dueDate", ascending: true)
        
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
            make.width.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        
        titleLabel.text = "전체"
        titleLabel.font = Font.heavy30
        titleLabel.textColor = Color.orange
        
        tableView.backgroundColor = .orange
        tableView.rowHeight = 100
        
    }
}

extension TaskListDetailViewController {
    
    func setupNavigationBar() {
        
        navPullDownBtn = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(dropDownNavBtnTapped))
        
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
        return addedTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListDetailVCTableViewCell.identifier, for: indexPath) as! TaskListDetailVCTableViewCell
        
        cell.configUI(data: addedTaskList[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteCell = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            
            try! self.realm.write{
                self.realm.delete(self.addedTaskList[indexPath.item])
                print("삭제완료")
            }
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteCell])
    }
}
