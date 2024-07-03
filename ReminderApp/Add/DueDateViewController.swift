//
//  DueDateViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit

import SnapKit

final class DueDateViewController: BaseViewController {
    
    let datePicker = UIDatePicker()
    var dueDatePicked:((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dueDatePicked?(dateToString())
        
    }
    
    override func configHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configLayout() {
        datePicker.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        datePicker.preferredDatePickerStyle = .inline
    }
    
    func dateToString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd EEEE"
        let dateString = dateFormatter.string(from: datePicker.date)
        return dateString
    }
}
