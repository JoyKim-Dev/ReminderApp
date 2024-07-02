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
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(30)
        }
        
        listCountLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.height.equalTo(30)
        }
    }
    
    override func configUI() {
        backgroundColor = .darkGray
        imageView.image = UIImage(systemName: "heart")
        
        categoryLabel.text = "오늘"
        categoryLabel.textColor = Color.white
        
        listCountLabel.text = "0"
        listCountLabel.font = Font.heavy30
        listCountLabel.textColor = Color.white
        
        
    }
    
    
}
