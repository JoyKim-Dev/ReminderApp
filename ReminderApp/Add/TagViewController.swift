//
//  TagViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/3/24.
//

import UIKit

import SnapKit

final class TagViewController: BaseViewController {
    
    private let tagTextField = UITextField()
    var sendTag: PassDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    deinit {
        print("tagVC deinit",self )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let tag = tagTextField.text ?? ""
        sendTag?.passDataValue(text: tag)
    }
   
    
    override func configHierarchy() {
        view.addSubview(tagTextField)
    }
    
    override func configLayout() {
        tagTextField.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        tagTextField.placeholder = "원하는 태그를 입력해보세요."
        tagTextField.backgroundColor = Color.lightGray
    }
}
