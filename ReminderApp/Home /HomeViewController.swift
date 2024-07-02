//
//  HomeViewController.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift

final class HomeViewController: BaseViewController {
    let realm = try! Realm()
   private var addTaskBtn: UIBarButtonItem!
   private var addCategoryBtn: UIBarButtonItem!
   private var navPullDownBtn: UIBarButtonItem!

    
   private let titleLabel = UILabel()
   private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: HomeViewCollectionViewCell.identifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func configHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    override func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configView() {
        setupToolBar()
        setupNavigationBar()
        
        titleLabel.text = "전체"
        titleLabel.font = Font.heavy30
        titleLabel.textColor = Color.orange
    }
    
}

extension HomeViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing:CGFloat = 10
        let cellSpacing:CGFloat = 12
        
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/4)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: 100, right: sectionSpacing)
        return layout
        
    }
    
    func setupNavigationBar() {
        
        navPullDownBtn = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(dropDownNavBtnTapped))
        
        let dueDateOrderFilter = UIAction(title: "마감임박순") { _ in
            print("마감임박")
            
        }
        
        let titleOrderFilter = UIAction(title: "제목순") { _ in
            print("제목순")
        }
        
        let lowPriorityOnlyFilter = UIAction(title: "우선순위 낮음만") { _ in
            print("우선순위낮음만")
        }
        
        let menu = UIMenu(title: "필터 옵션", options: .displayInline, children: [dueDateOrderFilter,titleOrderFilter,lowPriorityOnlyFilter])
        
        navPullDownBtn.menu = menu
      //  navPullDownBtn.showsMenuAsPrimaryAction = true
    
        navigationItem.rightBarButtonItem = navPullDownBtn
    }
    
    func setupToolBar(){
        navigationController?.isToolbarHidden = false
        
        addTaskBtn = UIBarButtonItem(title: "할일 추가", style: .plain, target: self, action: #selector(addTaskBtnTapped))
        
        addCategoryBtn = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(addCategoryBtnTapped))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        var items = [UIBarButtonItem]()
        
        [addTaskBtn, flexibleSpace, addCategoryBtn].forEach { items.append($0)
        }
        self.toolbarItems = items
    }
    
    @objc func addTaskBtnTapped() {
        print(#function)
        
        let nav = UINavigationController(rootViewController: AddTaskViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    @objc func addCategoryBtnTapped() {
        print(#function)
        
//        let nav = UINavigationController(rootViewController: TaskListDetailViewController())
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
    }
    
    @objc func dropDownNavBtnTapped() {
        
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCollectionViewCell.identifier, for: indexPath) as! HomeViewCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
      
        let count = realm.objects(TaskTable.self).count
        
        cell.configUI(count: count, row: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      let vc = TaskListDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
