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
