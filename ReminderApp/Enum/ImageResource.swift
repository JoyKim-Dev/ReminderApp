//
//  ImageResource.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

enum Icon {
    static let search = UIImage(systemName: "magnifyingglass")
    static let person = UIImage(systemName: "person")
    static let clock = UIImage(systemName: "clock")
    static let chevronRight = UIImage(systemName: "chevron.right")
    static let chevronLeft = UIImage(systemName: "chevron.left")
    static let xMark = UIImage(systemName: "xmark")
    static let cameraFill = UIImage(systemName: "camera.fill")
    static let likeSelected = UIImage(named: "like_selected")!.withRenderingMode(.alwaysOriginal)
    static let likeUnSelected = UIImage(named: "like_unselected")!.withRenderingMode(.alwaysOriginal)
}

enum CellIcon:String {
    
    case today = "t.circle.fill"
    case toDo = "calendar.circle.fill"
    case all = "folder.circle.fill"
    case flag = "flag.circle.fill"
    case done = "checkmark.circle.fill"
}
