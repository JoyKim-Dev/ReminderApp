//
//  ReusableIdentifierProtocol.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import Foundation

import UIKit

protocol ReuseIdentifierProtocol:AnyObject {
    static var identifier: String {get}
}

extension UIView: ReuseIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}
