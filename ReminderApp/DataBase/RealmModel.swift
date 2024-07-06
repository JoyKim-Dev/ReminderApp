//
//  RealmModel.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import Foundation
import RealmSwift


class TaskTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var taskTitle: String
    @Persisted var memoContent: String?
    @Persisted var dueDate: Date?
    @Persisted var tag: String?
    @Persisted var priorityCheck: String?
    @Persisted var flagMarked: Bool
    @Persisted var taskFinished: Bool
    
    convenience init(taskTitle: String, memoContent: String?, dueDate: Date?, tag: String?, priorityCheck: String?) {
       self.init()
       self.taskTitle = taskTitle
        self.memoContent = memoContent
        self.dueDate = dueDate
        self.tag = tag
        self.priorityCheck = priorityCheck
        self.flagMarked = false
        self.taskFinished = false
   }
}

