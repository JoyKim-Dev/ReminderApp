//
//  DueDateViewModel.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/9/24.
//

import Foundation

final class DueDateViewModel {
    
    // input: datePicker.date
    
    var inputDate: Observable<Date?> = Observable(nil)
    var outputValidDate = Observable(Date())
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var outputLabelText = Observable("")
    
    init() {
        print("DateViewModel Init")
        inputDate.bind { _ in
            self.dateToString()
        }
        
        outputValidDate.bind { _ in
            self.dateTodate()
        }
        // 오늘 날짜 바로 보여주기 위해 추가
        inputViewDidLoadTrigger.bind { _ in
            self.inputDate.value = Date()
            self.dateToString()
        }
    }
    
    private func dateTodate() {
        guard let date = inputDate.value else {return}
        
            let localTimeZone = TimeZone.current
            let convertedDate = date.addingTimeInterval(TimeInterval(localTimeZone.secondsFromGMT(for: date)))
        outputValidDate.value = convertedDate
        
        }
    
    
    private  func dateToString() {
        
        guard let date = inputDate.value else {return}
        
            let localTimeZone = TimeZone.current
            let convertedDate = date.addingTimeInterval(TimeInterval(localTimeZone.secondsFromGMT(for: date)))
            print (convertedDate)
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
        outputLabelText.value = dateFormatter.string(from: convertedDate)
        }
}


