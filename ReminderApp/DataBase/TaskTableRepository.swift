//
//  TaskTableRepository.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/4/24.
//

import Foundation
import RealmSwift

final class TaskTableRepository {
    
   private let realm = try! Realm()
    
    func fetchAll() -> [TaskTable] {
        
        let value = realm.objects(TaskTable.self).sorted(byKeyPath: "taskTitle", ascending: false)
        return Array(value)
    }
    
    func deleteItem(_ data: TaskTable) {
        try! realm.write{
            realm.delete(data)
            print("Realm delete succeed")}
    }
    
    func taskFinished(_ data: TaskTable) {
        
        try! realm.write {
            data.taskFinished.toggle()
        }
    } 
}
