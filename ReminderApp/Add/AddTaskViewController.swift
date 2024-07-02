//
//  addTaskViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//
import UIKit

import SnapKit
import RealmSwift


final class AddTaskViewController: BaseViewController {
    
    var navBackBtn: UIBarButtonItem!
    var navSaveBtn: UIBarButtonItem!
    
    var newTaskData:TaskTable?
    
    private let taskView = UIView()
    private let titleLabel = UILabel()
     private let titleTextField = UITextField()
    private let lineView = UIView()
    private let memoLabel = UILabel()
     private let memoTextView = UITextView()
    private var dueDateBtn = UIButton.Configuration.addTaskButton(title: "마감일")
    private let tagBtn = UIButton.Configuration.addTaskButton(title: "태그")
    private let priorityBtn = UIButton.Configuration.addTaskButton(title: "우선순위")
    private let addImageBtn = UIButton.Configuration.addTaskButton(title: "이미지추가")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "새로운 할 일"
        setupNavSaveBtn()
        setupNavBackBtn()
        
    }
    
    override func configHierarchy() {
        view.addSubview(taskView)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(lineView)
        view.addSubview(memoLabel)
        view.addSubview(memoTextView)
        view.addSubview(dueDateBtn)
        view.addSubview(tagBtn)
        view.addSubview(priorityBtn)
        view.addSubview(addImageBtn)
    }
    
    override func configLayout() {
        
        taskView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(taskView).inset(10)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.trailing.equalTo(taskView).inset(10)
            make.height.equalTo(20)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(taskView).inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(taskView).inset(10)
            make.width.equalTo(40)
            make.height.equalTo(20)
            
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.leading.equalTo(taskView).inset(50)
            make.trailing.bottom.equalTo(taskView).inset(10)
        }
        
        dueDateBtn.snp.makeConstraints { make in
            make.top.equalTo(taskView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
           
        }
        
        tagBtn.snp.makeConstraints { make in
            make.top.equalTo(dueDateBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
           
        }
        
        priorityBtn.snp.makeConstraints { make in
            make.top.equalTo(tagBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
           
        }
        
        addImageBtn.snp.makeConstraints { make in
            make.top.equalTo(priorityBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
           
        }
    }
    
    override func configView() {
        taskView.backgroundColor = Color.mediumGray
        taskView.layer.cornerRadius = 10
        taskView.clipsToBounds = true
        memoTextView.backgroundColor = Color.mediumGray
        memoTextView.font = Font.semiBold14
        
        lineView.backgroundColor = Color.lightGray
        
        titleLabel.text = "제목"
        titleLabel.textColor = Color.lightGray
        memoLabel.text = "메모"
        memoLabel.textColor = Color.lightGray
    }
}

extension AddTaskViewController {
    
    private func setupNavBackBtn() {
        
        navBackBtn = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(navBackBtnTapped))
        
        navigationItem.leftBarButtonItem = navBackBtn
    }
    
    @objc func navBackBtnTapped() {
        dismiss(animated: true)
    }
    
    private func setupNavSaveBtn() {
        
        navSaveBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(navSaveBtnTapped))
        
        navigationItem.rightBarButtonItem = navSaveBtn
    }
    // DB에 데이터 저장!
    @objc func navSaveBtnTapped() {
        print(#function)
//        빈칸찾기
        let realm = try! Realm()
        
//        내용 채우기
        
        guard let title = titleTextField.text, !title.isEmpty else {
            let alert = UIAlertController(
                title: "제목이 입력되지 않았습니다.",
                message: "제목 입력 후 다시 저장 시도해주세요",
                preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        
        newTaskData = TaskTable(taskTitle: title, memoContent: memoTextView.text, dueDate: Date(), tag: nil, priorityCheck: nil, image: nil)
        
//        저장 요청
        guard let data = newTaskData else {
            print("데이터값없음")
            return
        }
        try! realm.write{
            realm.add(data)
            print("저장완료")
        }
        
        
        
        dismiss(animated: true)
        }

    }


//final class AddTaskViewController: BaseViewController {
//    
//    private let tableView = UITableView()
//    var navBackBtn: UIBarButtonItem!
//    var navSaveBtn: UIBarButtonItem!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationItem.title = "새로운 할 일"
//        setupNavSaveBtn()
//        setupNavBackBtn()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(AddTaskVCTableViewCell.self, forCellReuseIdentifier: AddTaskVCTableViewCell.identifier)
//        tableView.register(AddTaskVCTableViewCellTitleMemo.self, forCellReuseIdentifier: AddTaskVCTableViewCellTitleMemo.identifier)
//    }
//    
//    override func configHierarchy() {
//        view.addSubview(tableView)
//    }
//    
//    override func configLayout() {
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
//        }
//    }
//    
//    override func configView() {
//
//    }
//}
//
//extension AddTaskViewController {
//    
//    private func setupNavBackBtn() {
//        
//        navBackBtn = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(navBackBtnTapped))
//        
//        navigationItem.leftBarButtonItem = navBackBtn
//        
//    }
//    
//    @objc func navBackBtnTapped() {
//        dismiss(animated: true)
//    }
//    
//    private func setupNavSaveBtn() {
//        
//        navSaveBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(navSaveBtnTapped))
//        
//        navigationItem.rightBarButtonItem = navSaveBtn
//    }
//    // DB에 데이터 저장!
//    @objc func navSaveBtnTapped() {
//        print(#function)
////        빈칸찾기
//        let realm = try! Realm()
//        
////        내용 채우기
//        
//        guard let taskTitle =
//        
////        저장 요청
//
//
//
//    }
//}
//
//extension AddTaskViewController:UITableViewDelegate, UITableViewDataSource {
//
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        5
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        if indexPath.section == 0 {
//            return 250
//        } else {
//            return 50
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let headerView = UIView()
//        
//        headerView.backgroundColor = view.backgroundColor
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: AddTaskVCTableViewCellTitleMemo.identifier, for: indexPath) as! AddTaskVCTableViewCellTitleMemo
//            
//            cell.layer.cornerRadius = 10
//            cell.clipsToBounds = true
//            
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: AddTaskVCTableViewCell.identifier, for: indexPath) as! AddTaskVCTableViewCell
//            
//            cell.layer.cornerRadius = 10
//            cell.clipsToBounds = true
//            cell.configUI(section: indexPath.section)
//            
//            return cell
//            
//        }
//        
//    }
//}

