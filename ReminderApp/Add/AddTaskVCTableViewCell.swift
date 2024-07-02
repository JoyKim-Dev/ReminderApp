////
////  addTaskVCTableViewCell.swift
////  ReminderApp
////
////  Created by Joy Kim on 7/2/24.
////
//
//import UIKit
//
//import SnapKit
//
//final class AddTaskVCTableViewCell: BaseTableViewCell {
//    
//    let titleLabel = UILabel()
//    let toNextPageBtn = UIButton()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
//    
//    override func configHierarchy() {
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(toNextPageBtn)
//    }
//    
//    override func configLayout() {
//        
//        backgroundColor = .lightGray
//        
//        titleLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(contentView)
//            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(30)
//        }
//        
//        toNextPageBtn.snp.makeConstraints { make in
//            make.centerY.equalTo(contentView)
//            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
//            make.height.width.equalTo(30)
//        }
//    }
//    
//     func configUI(section: Int) {
//         super.configUI()
//         titleLabel.textColor = Color.white
//         
//         toNextPageBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
//         
//         if section == 1 {
//             titleLabel.text = "마감일"
//         } else if section == 2 {
//             titleLabel.text = "태그"
//         } else if section == 3 {
//             titleLabel.text = "우선 순위"
//         } else if section == 4 {
//             titleLabel.text = "이미지 추가"
//         }
//    }    
//}
