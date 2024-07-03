//
//  LabelButton.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit
import SnapKit

class LabelButton: UIButton {
    
    let label = UILabel()
    let newImageView = UIImageView()
    
    init(title: String, text: String = "") {
        super.init(frame: .zero)
    
        setTitle(title, for: .normal)
        backgroundColor = Color.mediumGray
        layer.cornerRadius = 10
        tintColor = Color.white
        let screenWidth = UIScreen.main.bounds.width
        let titleWidth = (title as NSString).size(withAttributes: [.font:self.titleLabel?.font]).width
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: screenWidth - titleWidth - 50)
        label.text = text
        
        configHierarchy()
                configLayout()
                configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LabelButton {
    
    func configHierarchy(){
        self.addSubview(label)
        self.addSubview(newImageView)
        
    }
    
    func configLayout() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        newImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    func configUI() {
        label.textColor = Color.white
        newImageView.image = UIImage(systemName: "chevron.right")
    }
}
