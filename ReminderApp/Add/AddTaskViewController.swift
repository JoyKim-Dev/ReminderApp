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
    private var dueDateBtn = LabelButton(title: "마감일")
    private var tagBtn = LabelButton(title: "태그")
    private var priorityBtn = LabelButton(title: "우선 순위")
    private var addImageBtn = LabelButton(title: "이미지 추가")
    
    private let btnLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "새로운 할 일"
        titleTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(priorityReceivedNotification), name: NSNotification.Name("send Priority"), object: nil)
        
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
        view.addSubview(btnLabel)
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
            make.height.equalTo(50)
            
        }
        
        
        tagBtn.snp.makeConstraints { make in
            make.top.equalTo(dueDateBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
            
        }
        
        priorityBtn.snp.makeConstraints { make in
            make.top.equalTo(tagBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
            
        }
        
        addImageBtn.snp.makeConstraints { make in
            make.top.equalTo(priorityBtn.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
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
        
        dueDateBtn.addTarget(self, action: #selector(dueDateBtnTapped), for: .touchUpInside)
        tagBtn.addTarget(self, action: #selector(tagBtnTapped), for: .touchUpInside)
        priorityBtn.addTarget(self, action: #selector(priorityBtnTapped), for: .touchUpInside)
        
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
        
        guard let date = dueDateBtn.label.text, let tag = tagBtn.label.text else {return}
        
        
        newTaskData = TaskTable(taskTitle: title, memoContent: memoTextView.text, dueDate: date, tag: tag, priorityCheck: nil, image: nil)
        navBackBtn.isEnabled = true
        
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
    @objc func dueDateBtnTapped() {
        
        let vc = DueDateViewController()
        vc.dueDatePicked = { value in
            
            self.dueDateBtn.label.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tagBtnTapped() {
        
        let vc = TagViewController()
        vc.sendTag = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func priorityBtnTapped() {

        let vc = PriorityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func priorityReceivedNotification(notification: NSNotification) {
        (#function)
        print("받음")
        if let result = notification.userInfo?["priority"] as? Int {
            
            switch result {
            case 0:
                priorityBtn.label.text = "높음"
            case 1:
                priorityBtn.label.text = "보통"
            case 2:
                priorityBtn.label.text = "낮음"
            default:
                priorityBtn.label.text = ""
            }
        }
    }
}


extension AddTaskViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ((titleTextField.text?.isEmpty) != nil) {
            navSaveBtn.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if titleTextField.text != nil {
            navSaveBtn.isEnabled = true
            
        }
        return true
    }
}

extension AddTaskViewController: PassDataDelegate {
    func passDataValue(text: String) {
        if text.isEmpty {
            tagBtn.label.text = text
        } else {
            tagBtn.label.text = "#\(text)"
        }
        tagBtn.label.textColor = .blue
        tagBtn.label.font = Font.semiBold15
        print(text)
    }
    
    
}

