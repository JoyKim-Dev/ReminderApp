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
    let cellImageView = UIImageView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configHierarchy() {
        contentView.addSubview(checkBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(cellImageView)
        
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
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(checkBtn.snp.trailing).offset(10)
        }
    
        cellImageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(cellImageView.snp.height).multipliedBy(0.7)
        }
        
        
    }
    
    func configUI(data: TaskTable) {
        super.configUI()
        if data.taskFinished {
            checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkBtn.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    
        if let priority = data.priorityCheck, !priority.isEmpty {
            
            switch priority {
            case "높음":
                titleLabel.text = "!!! \(data.taskTitle)"
            case "보통":
                titleLabel.text = "!! \(data.taskTitle)"
            case "낮음":
                titleLabel.text = "! \(data.taskTitle)"
            default:
                break
            }
        } else {
            
            titleLabel.text = data.taskTitle
        }
        
        memoLabel.text = data.memoContent
        
        // text에 넣기 위해 Date -> String 변경 작업
        
        func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter.string(from: date)
        }
        
        guard let date = data.dueDate else {return}
        
        dateLabel.text = dateToString(date: date)
        tagLabel.text = data.tag
        tagLabel.textColor = .blue  
        
        cellImageView.image = loadImageToDocument(filename: "\(data.id)")
        cellImageView.clipsToBounds = true
        cellImageView.contentMode = .scaleAspectFit
    }
    
}
