//
//  taskListDetailVCTableViewCell.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class TaskListDetailVCTableViewCell: BaseTableViewCell {
    
    let checkBtn = UIButton()
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    let tagLabel = UILabel()
   
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configHierarchy() {
        contentView.addSubview(checkBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
        
    }
    
    override func configLayout() {
        checkBtn.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView).inset(10)
            make.leading.equalTo(checkBtn.snp.trailing).offset(10)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(checkBtn.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalTo(checkBtn.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(5)
            make.leading.equalTo(dateLabel.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
        
     
    }
    
    func configUI(data: TaskTable) {
        super.configUI()
        checkBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        
        titleLabel.text = data.taskTitle
        memoLabel.text = data.memoContent
        
        dateLabel.text = data.dueDate
    }
    
}
