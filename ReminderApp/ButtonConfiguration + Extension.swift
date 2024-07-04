//
//  ButtonConfiguration + Extension.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func addTaskButton(title: String) -> UIButton{
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        configuration.title = title
        configuration.attributedTitle?.font = Font.semiBold15
        configuration.baseForegroundColor = Color.white
        configuration.baseBackgroundColor = Color.mediumGray
        configuration.buttonSize = .large
        configuration.titleAlignment = .leading
        configuration.imagePlacement = .trailing
        configuration.image = UIImage(systemName: "chevron.right")
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }
 
}

extension Date {

    /**
     # dateCompare
     - Parameters:
        - fromDate: 비교 대상 Date
     - Note: 두 날짜간 비교해서 과거(Future)/현재(Same)/미래(Past) 반환
    */
    public func dateCompare(fromDate: Date) -> String {
        var strDateMessage:String = ""
        let result:ComparisonResult = self.compare(fromDate)
        switch result {
        case .orderedAscending:
            strDateMessage = "Future"
            break
        case .orderedDescending:
            strDateMessage = "Past"
            break
        case .orderedSame:
            strDateMessage = "Same"
            break
        default:
            strDateMessage = "Error"
            break
        }
        return strDateMessage
    }
}

