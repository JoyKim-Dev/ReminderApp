//
//  TaskDetailViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//
import UIKit

import SnapKit
import RealmSwift
import Toast

class TaskDetailViewController: BaseViewController {
    
    let realm = try! Realm()
    
    let titletextField = UILabel()
    let taskImageView = UIImageView()
    let flagImageView = UIImageView()
    let priorityLabel = LabelForStackView()
    let dueDateLabel = LabelForStackView()
    let memoContentTextView = UITextView()
    let finishedTaskButton = UIButton()
    lazy var flagPriorityDuedateStackView = UIStackView()
    
    var list:TaskTable?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configHierarchy() {
        view.addSubview(titletextField)
        view.addSubview(taskImageView)
        view.addSubview(memoContentTextView)
        view.addSubview(finishedTaskButton)
        view.addSubview(flagPriorityDuedateStackView)
        
        flagPriorityDuedateStackView.addArrangedSubview(dueDateLabel)
        flagPriorityDuedateStackView.addArrangedSubview(priorityLabel)
        flagPriorityDuedateStackView.addArrangedSubview(flagImageView)
        
    }
    
    override func configLayout() {
        titletextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
        flagPriorityDuedateStackView.snp.makeConstraints { make in
            make.top.equalTo(titletextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        memoContentTextView.snp.makeConstraints { make in
            make.top.equalTo(flagPriorityDuedateStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }
        taskImageView.snp.makeConstraints { make in
            make.top.equalTo(memoContentTextView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        finishedTaskButton.snp.makeConstraints { make in
            make.top.equalTo(taskImageView.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
    }
    
    override func configView() {
        navigationItem.title = "상세화면"
        
        titletextField.text = list?.taskTitle
        titletextField.textAlignment = .center
        titletextField.font = Font.heavy30
        
        memoContentTextView.text = list?.memoContent
        
        flagPriorityDuedateStackView.axis = .horizontal
        flagPriorityDuedateStackView.distribution = .equalSpacing
        flagPriorityDuedateStackView.spacing = 5
        flagPriorityDuedateStackView.backgroundColor = Color.orange.withAlphaComponent(0.5)
        
        func dateToString(date: Date) -> String {
                let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC")
                    return dateFormatter.string(from: date)
                }
        let stringDate = dateToString(date: list?.dueDate ?? Date())
        
        dueDateLabel.text = "마감기한: \(stringDate)"
        priorityLabel.text = "중요도: \(list?.priorityCheck ?? "")"
        
        guard let flag = list?.flagMarked else {return}
        
        if flag {
            flagImageView.image = UIImage(systemName: "flag.fill")
        } else {
            flagImageView.image = UIImage(systemName: "flag")
        }
        
        taskImageView.image = UIImage(systemName: "star")
        taskImageView.contentMode = .scaleAspectFit
        
        taskImageView.backgroundColor = .systemRed
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Color.orange
        configuration.baseForegroundColor = Color.white
        configuration.cornerStyle = .capsule
        guard let finished = list?.taskFinished else {return}
        
        if finished {
            finishedTaskButton.setTitle("완료됨", for: .normal)
            configuration.baseBackgroundColor = Color.unselectedGray
            finishedTaskButton.isEnabled = false
        } else {
            finishedTaskButton.setTitle("완료", for: .normal)

          configuration.baseBackgroundColor = Color.orange
            finishedTaskButton.isEnabled = true
        }
        
       finishedTaskButton.configuration = configuration
        finishedTaskButton.addTarget(self, action: #selector(finishedBtnTapped), for: .touchUpInside)
        print("여기")
    }
  
}
// 왜 addTarget이 안될까!!
extension TaskDetailViewController {
    
    @objc func finishedBtnTapped() {
        print(#function)
        
        try! realm.write {
            list?.taskFinished.toggle()
            self.view.makeToast("완료 상태가 변경 되었습니다.")
        }
    }
}
