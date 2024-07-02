//
//  HomeViewCollectionViewCell.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

import SnapKit

final class HomeViewCollectionViewCell:BaseCollectionViewCell {
    
   private let imageView = UIImageView()
   private let categoryLabel = UILabel()
   private let listCountLabel = UILabel()
    
    let categoryList = ["오늘", "예정", "전체", "깃발표시", "완료됨"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
 
    }
    override func configHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(listCountLabel)
    }
    
    override func configLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.width.equalTo(30)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.width.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            
        }
        
        listCountLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.height.equalTo(30)
        }
    }
    
    func configUI(count:Int, row: Int) {
         super.configUI()
        backgroundColor = .darkGray
        imageView.image = UIImage(systemName: "heart")
        
        
        categoryLabel.textColor = Color.white
        
        categoryLabel.text = categoryList[row]

        listCountLabel.text = String(count)
        listCountLabel.font = Font.heavy30
        listCountLabel.textColor = Color.white
        
        
    }
    
    
}
