//
//  CalendarViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/6/24.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift

final class CalendarViewController: BaseViewController {
    
    var calendar = FSCalendar()
    var selectedDate = Date()
    var swipeUp: UISwipeGestureRecognizer!
       var swipeDown: UISwipeGestureRecognizer!
    var isWeeklyView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    override func configHierarchy() {
        view.addSubview(calendar)
    }
    
    override func configLayout() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(calendar.snp.width).multipliedBy(1.5)
        }
    }
    
    override func configView() {
        navigationItem.title = "CALENDAR"
        

        calendar.scrollEnabled = true
        calendar.scrollDirection = .vertical
        
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
              swipeUp.direction = .up
              calendar.addGestureRecognizer(swipeUp)
              
              swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:)))
              swipeDown.direction = .down
              calendar.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        
        if swipe.direction == .up && !isWeeklyView {
            calendar.setScope(.week, animated: true)
            calendar.snp.updateConstraints { make in
                make.height.equalTo(100)
            }
            isWeeklyView = true
        } else if swipe.direction == .down && isWeeklyView {
            calendar.setScope(.month, animated: true)
            calendar.snp.updateConstraints { make in
                make.height.equalTo(calendar.snp.width).multipliedBy(1.5)
            }
            isWeeklyView = false
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let realm = try! Realm()
        
        var calendar = Calendar.current
                let startOfDay = calendar.startOfDay(for: date)
                guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else { return }
        
        
        let predicate = NSPredicate(format: "dueDate >= %@ AND dueDate < %@", startOfDay as NSDate, endOfDay as NSDate)
        let filteredTask = realm.objects(TaskTable.self).filter(predicate).sorted(byKeyPath: "taskTitle", ascending: true)
        
        
        let vc = TaskListDetailViewController()
        vc.addedTaskList = filteredTask
        navigationController?.pushViewController(vc, animated: true)
    }

}
