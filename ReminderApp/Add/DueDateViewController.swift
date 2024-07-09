//
//  DueDateViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit

import SnapKit

final class DueDateViewController: BaseViewController {
    
    
   private let viewModel = DueDateViewModel()
   private let datePicker = UIDatePicker()
    private let dateLabel = {
        let view = UILabel()
        view.font = Font.semiBold15
        view.textAlignment = .center
        return view
    }()
   var dueDatePicked:((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        let selectedDate = datePicker.date
//        let localTimeZone = TimeZone.current
//        print(selectedDate)
//        let convertedDate = selectedDate.addingTimeInterval(TimeInterval(localTimeZone.secondsFromGMT(for: selectedDate)))
//        print (convertedDate)
           //    dueDatePicked?(convertedDate)
    }
    
    override func configHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(dateLabel)
    }
    
    override func configLayout() {
        datePicker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.6)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
    
    override func configView() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.timeZone = TimeZone(abbreviation: "KST")
        datePicker.locale = Locale(identifier: "ko_KR")
        
        datePicker.addTarget(self, action: #selector(datePickerPicked), for: .valueChanged)
    }
    
   private func bindData() {
       viewModel.outputLabelText.bind { value in
           print("dndhkdkdkdk")
           self.dateLabel.text = value
       }
    }
   
    @objc private func datePickerPicked() {
        print(#function)
        viewModel.inputDate.value = datePicker.date
    }
}
