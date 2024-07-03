//
//  CustomLabel.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit

class LabelForStackView: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        font = Font.semiBold14
        textAlignment = .center
        layer.cornerRadius = 10
        clipsToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
