////
////  AddTaskVCTableViewCellTitleMemo.swift
////  ReminderApp
////
////  Created by Joy Kim on 7/2/24.
////
//
//import UIKit
//
//import SnapKit
//
//final class AddTaskVCTableViewCellTitleMemo: BaseTableViewCell {
//    
//   private let titleLabel = UILabel()
//    private let titleTextFiled = UITextField()
//   private let lineView = UIView()
//   private let memoLabel = UILabel()
//    private let memoTextView = UITextView()
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
//        contentView.addSubview(lineView)
//        contentView.addSubview(memoLabel)
//        contentView.addSubview(titleTextFiled)
//        contentView.addSubview(memoTextView)
//    }
//    
//    override func configLayout() {
//        titleLabel.snp.makeConstraints { make in
//            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(20)
//            make.width.equalTo(40)
//        }
//        
//        titleTextFiled.snp.makeConstraints { make in
//            make.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
//            make.height.equalTo(20)
//            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
//        }
//        
//        lineView.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.horizontalEdges.equalTo(contentView).inset(5)
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//        }
//        memoLabel.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.bottom).offset(10)
//            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
//            make.width.equalTo(40)
//            make.height.equalTo(20)
//            
//        }
//        
//        memoTextView.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.bottom).offset(10)
//            make.leading.equalTo(contentView).inset(50)
//            make.trailing.bottom.equalTo(contentView).inset(10)
//        }
//    }
//    
//    override func configUI() {
//        
//        backgroundColor = .lightGray
//        memoTextView.backgroundColor = .lightGray
//        memoTextView.font = Font.semiBold14
//        
//        lineView.backgroundColor = .gray
//        
//        titleLabel.text = "제목"
//        titleLabel.textColor = Color.darkGray
//        memoLabel.text = "메모"
//        memoLabel.textColor = Color.darkGray
//    }
//    
//}
