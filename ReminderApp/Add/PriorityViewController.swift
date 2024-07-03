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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendPriorityNotification), name: NSNotification.Name("send Priority"), object: nil)
    }
    
    deinit {
        print("priorityVC deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        NotificationCenter.default.post(name: NSNotification.Name("send Priority"), object: nil, userInfo: ["priority": prioritySegment.selectedSegmentIndex])
        print(prioritySegment.selectedSegmentIndex)
        
    }
    
    override func configHierarchy() {
        view.addSubview(prioritySegment)
    }
    
    override func configLayout() {
        prioritySegment.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configView() {
       configSegmentUI()
    }
}

extension PriorityViewController {
    
    func configSegmentUI() {
        prioritySegment.insertSegment(withTitle: "높음", at: 0, animated: true)
        prioritySegment.insertSegment(withTitle: "보통", at: 1, animated: true)
        prioritySegment.insertSegment(withTitle: "낮음", at: 2, animated: true)
        
        prioritySegment.selectedSegmentIndex = 0
    }
    
    @objc func sendPriorityNotification(notification:NSNotification) {
        print(#function, notification.userInfo)
    }
}
