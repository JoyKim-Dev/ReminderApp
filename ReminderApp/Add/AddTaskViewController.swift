//
//  addTaskViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

import SnapKit

final class AddTaskViewController: BaseViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configLayout() {
        <#code#>
    }
    
    override func configView() {
        <#code#>
    }
}

extension addTaskViewController {
    
    
}

extension addTaskViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
}


