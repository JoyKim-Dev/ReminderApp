//
//  PriorityViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit

import SnapKit

final class PriorityViewController: BaseViewController {
    
    let prioritySegment = UISegmentedControl()
    let priorityLabel = UILabel()
    let viewModel = PriorityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendPriorityNotification), name: NSNotification.Name("send Priority"), object: nil)
        
        viewModel.inputViewDidLoadTrigger.value = ()
        bindData()
    }
    
    deinit {
        print("priorityVC deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let index = viewModel.outputIndex.value {
            
            NotificationCenter.default.post(name: NSNotification.Name("send Priority"), object: nil, userInfo: ["priority": index])
            print(index)
        }
    }
    
    override func configHierarchy() {
        view.addSubview(prioritySegment)
        view.addSubview(priorityLabel)
    }
    
    override func configLayout() {
        prioritySegment.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(40)
            make.width.equalTo(view).inset(20)
        }
    }
    
    override func configView() {
       configSegmentUI()
        
        priorityLabel.textAlignment = .center
        priorityLabel.font = Font.heavy30
    }
}

extension PriorityViewController {
    
    func configSegmentUI() {
        prioritySegment.insertSegment(withTitle: "높음", at: 0, animated: true)
        prioritySegment.insertSegment(withTitle: "보통", at: 1, animated: true)
        prioritySegment.insertSegment(withTitle: "낮음", at: 2, animated: true)
        
        prioritySegment.selectedSegmentIndex = 0
        
        prioritySegment.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
    }
    
    func bindData() {
        
        viewModel.outputLabelText.bind { value in
            self.priorityLabel.text = value
        }
        
    }
    
    @objc func sendPriorityNotification(notification:NSNotification) {
        print(#function, notification.userInfo)
    }
    
    @objc private func segmentSelected() {
        viewModel.inputSegmentSelectedIndex.value = prioritySegment.selectedSegmentIndex
    }
}
