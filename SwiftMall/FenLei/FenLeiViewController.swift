//
//  FenLeiViewController.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/9/17.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit

class FenLeiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var categoryDataArr = [CategoryModel]()
    var _index: Int?
    var leftTableView: UITableView?
    var categroyCollectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        _index = 0
        self.view.backgroundColor = UIColor.white
        leftTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: kScreenHeight), style: .plain)
        leftTableView?.delegate = self
        leftTableView?.dataSource = self
        leftTableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        leftTableView?.tableFooterView = UIView.init(frame: CGRect.init())
        self.view.addSubview(leftTableView!)
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: (kScreenWidth-90-50)/3.0, height: (kScreenWidth-90-50)/3.0+30)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        categroyCollectionView = UICollectionView.init(frame: CGRect.init(x: 90, y: 0, width: kScreenWidth-90, height: kScreenHeight), collectionViewLayout: flowLayout)
        categroyCollectionView?.delegate = self
        categroyCollectionView?.dataSource = self
        categroyCollectionView?.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        categroyCollectionView?.register(CategoryHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategorySectionHeaderView")
        self.view.addSubview(categroyCollectionView!)
        categroyCollectionView?.backgroundColor = UIColor.white
        NetWorkRequest(.categray, completion: { (responseString) -> (Void) in
            if let daliyItems = [CategoryModel].deserialize(from: responseString, designatedPath: "sub_tree_cate") {
                daliyItems.forEach({ (item) in
                    self.categoryDataArr.append(item!)
                })
                self.leftTableView?.reloadData()
                self.categroyCollectionView?.reloadData()
            }
        }) { (error) -> (Void) in
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryDataArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))!
        cell.textLabel?.text = self.categoryDataArr[indexPath.section].name
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _index = indexPath.section
        categroyCollectionView?.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.categoryDataArr.count < 1 {
            return 0;
        }
        let categoryModel: CategoryModel = self.categoryDataArr[_index!]
        return categoryModel.menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryModel: CategoryModel = self.categoryDataArr[_index!]
        let categorySubModel: CategorySubModel = categoryModel.menu[section]
        return categorySubModel.menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categroyCell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let categoryModel: CategoryModel = self.categoryDataArr[_index!]
        let categorySubModel: CategorySubModel = categoryModel.menu[indexPath.section]
        let model: CategoryGoodsModel = categorySubModel.menu[indexPath.row]
        categroyCell.setModel(model: model)
        return categroyCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: kScreenWidth, height: 30)

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
           let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategorySectionHeaderView", for: indexPath) as! CategoryHeaderView
            let categoryModel: CategoryModel = self.categoryDataArr[_index!]
            let categorySubModel: CategorySubModel = categoryModel.menu[indexPath.section]
            headerview.titleLabel.text = categorySubModel.name
            return headerview
        }else{
            let footerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            footerview.backgroundColor = UIColor.purple
            return footerview
        }
        

    }
}
