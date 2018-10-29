//
//  ProductDetailViewController.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/5.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import ZCycleView

class ProductDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var gid: String?
    var productDetailTableView: UITableView?
    var headCycleView: ZCycleView?
    var productDetailModel: ProductDetailModel?
    var webHeight: CGFloat = 60;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupSubviews()
        self.loadData()
    }
    private func loadData(){
        var paraDict: [String:Any] = Dictionary()
        paraDict["id"] = gid ?? ""
        NetWorkRequest(.productDetail(parameters: paraDict), completion: { (responseString) -> (Void) in
            self.productDetailModel = ProductDetailModel.deserialize(from: responseString)
            let detail_pic_list: [String] = self.productDetailModel?.goods!["detail_pic_list"] as! [String]
            self.headCycleView?.setUrlsGroup(detail_pic_list)
            self.productDetailTableView?.reloadData()
            
        }) { (responseString) -> (Void) in
            
        }
    }
    private func setupSubviews(){
        self.title = "商品详情"
        productDetailTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width:kScreenWidth , height: kScreenHeight), style: .plain)
        productDetailTableView?.delegate = self
        productDetailTableView?.dataSource = self
        productDetailTableView?.rowHeight =  UITableViewAutomaticDimension
        self.view.addSubview(productDetailTableView!)
        productDetailTableView?.register(ProductDetailCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(ProductDetailCell.classForCoder()))
        productDetailTableView?.register(WebCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(WebCell.classForCoder()))
        headCycleView = ZCycleView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth))
        headCycleView?.placeholderImage = UIImage.init(named: "YSJJ_squareDefaultImage")
        productDetailTableView?.tableHeaderView = headCycleView
        NotificationCenter.default.addObserver(self, selector: #selector(refreshProductDetailWebHeight(notificaton:)), name: NSNotification.Name(rawValue: "refreshProductDetailWebHeight"), object: nil)

    }
    @objc func refreshProductDetailWebHeight(notificaton: NSNotification) {
        webHeight = (notificaton.userInfo?["height"] as? CGFloat)!
        self.productDetailTableView?.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.productDetailModel != nil){
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: ProductDetailCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ProductDetailCell.classForCoder()), for: indexPath) as! ProductDetailCell
            cell.setData(goods: (self.productDetailModel?.goods)!)
            return cell
        }else{
            let cell: WebCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(WebCell.classForCoder()), for: indexPath) as! WebCell
            cell.setUrl(url: (self.productDetailModel?.detail_url)!)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }
        return webHeight

    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
