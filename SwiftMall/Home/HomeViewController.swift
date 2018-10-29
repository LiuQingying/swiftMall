//
//  HomeViewController.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/9/15.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import Alamofire
import ZCycleView
import Moya
import SwiftyJSON
class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HomeGoodsCellDelgate {
    
    var homeTableView: UITableView?
    var headCycleView: ZCycleView?
    var homeDataArr = [GoodsModel]()
    var ad2List = [AdModel]()
    var ad3List = [AdModel]()
    var recommend_list = [GoodsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubvies()
        loadData()
        
    }
    private func loadData() {
        NetWorkRequest(.homeData) { (responseString) -> (Void) in
            self.homeDataArr.removeAll()
            
            if let daliyItems = [GoodsModel].deserialize(from: responseString, designatedPath: "like_list") {
                daliyItems.forEach({ (item) in

                    self.homeDataArr.append(item!)
                    
                })
            }
            if let adItems = [AdModel].deserialize(from: responseString, designatedPath: "ad1_list") {
                var adDataArr = [String]()

                adItems.forEach({ (item) in
                    adDataArr.append((item?.img)!)
                })
                self.headCycleView?.setUrlsGroup(adDataArr)
            }
            if let ad2_list = [AdModel].deserialize(from: responseString, designatedPath: "ad2_list") {
                ad2_list.forEach({ (item) in
                    
                    self.ad2List.append(item!)
                    
                })
            }
            if let ad3_list = [AdModel].deserialize(from: responseString, designatedPath: "ad3_list") {
                ad3_list.forEach({ (item) in
                    
                    self.ad3List.append(item!)
                    
                })
            }
            if let recommend_list = [GoodsModel].deserialize(from: responseString, designatedPath: "recommend_list") {
                recommend_list.forEach({ (item) in
                    
                    self.recommend_list.append(item!)
                    
                })
            }
            self.homeTableView?.reloadData()
            
        }
    }
    private func setupSubvies() {
        headCycleView = ZCycleView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 0.33*kScreenWidth))
        headCycleView?.placeholderImage = UIImage.init(named: "YSJJ_rectangleDefaultImage")
        homeTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        homeTableView?.delegate = self
        homeTableView?.dataSource = self;
        self.view.addSubview(homeTableView!)
        homeTableView?.register(HomeGoodsCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(HomeGoodsCell.classForCoder()))
        homeTableView?.register(HomeSectionHaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: NSStringFromClass(HomeSectionHaderView.classForCoder()))
        homeTableView?.tableHeaderView = headCycleView
    }
    func homeGoodsCell(goodsCell: HomeGoodsCell) {
        print("代理")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.ad3List.count > 0 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.homeDataArr.count
        default:
            return self.recommend_list.count

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeGoodsCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HomeGoodsCell.classForCoder()), for: indexPath) as! HomeGoodsCell
        cell.delegate = self
        if indexPath.section == 0 {
            let model = self.homeDataArr[indexPath.row]
            cell.setModel(model: model)
            cell.clickButton = ({(str: String) -> Void in
                print(str)
            })
        }else{
            let model = self.homeDataArr[indexPath.row]
            cell.setModel(model: model)
            cell.clickButton = ({(str: String) -> Void in
                print(str)
            })
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if(self.ad2List.count > 0){
                let model = self.ad2List[0]
                let height: CGFloat =  model.location!["height"] as! CGFloat
                let width: CGFloat =  model.location!["width"] as! CGFloat
                return kScreenWidth * height / width
            }
        }else{
            if(self.ad3List.count > 0){
                let model = self.ad3List[0]
                let height: CGFloat =  model.location!["height"] as! CGFloat
                let width: CGFloat =  model.location!["width"] as! CGFloat
                return kScreenWidth * height / width
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HomeSectionHaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(HomeSectionHaderView.classForCoder())) as! HomeSectionHaderView
        if section == 0 {
            if(self.ad2List.count > 0){
                headerView.setModel(model: self.ad2List[0])
            }
            return headerView
        }else if section == 1 {

            if(self.ad3List.count > 0){
                headerView.setModel(model: self.ad3List[0])
            }
            return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailViewController()
        let model = self.homeDataArr[indexPath.row]
        vc.gid =  model.id?.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

