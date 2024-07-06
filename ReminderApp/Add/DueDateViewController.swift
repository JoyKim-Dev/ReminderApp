//
//  DueDateViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit

import SnapKit

final class DueDateViewController: BaseViewController {
    
   private let datePicker = UIDatePicker()
   var dueDatePicked:((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dueDatePicked?(datePicker.date)
        
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
    
}
