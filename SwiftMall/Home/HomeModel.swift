//
//  HomeModel.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/9/17.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import HandyJSON
class HomeModel: HandyJSON {
    var ad1_list = [AdModel]()
    var ad2_list = [AdModel]()
    var ad3_list = [AdModel]()
    var ad4_list = [AdModel]()
    var recommend_list = [AdModel]()
    var like_list = [GoodsModel]()
    var today_special_list = [AdModel]()

    required init() {}

}
class GoodsModel: HandyJSON {
    
    /// 商品id
    var id: Int?

    /// 商品标题
    var title: String?
    
    /// 厂家直发
    var supplier_id: String?
    
    /// 商品图片
    var main_pic: String?
    
    /// 商品价格
    var price: String?
    
    /// 商品现价
    var d_price: String?
    
    /// 商品描述
    var desc: String?
    
    /// 数量
    var amount: Int?
    required init() {}
}
class AdModel: HandyJSON {
    
    /// 商品id
    var id: Int?
    
    /// 商品标题
    var name: String?
    
    /// 厂家直发
    var supplier_id: String?
    
    /// 商品图片
    var img: String?
    
    /// 图片
    var url: String?
    
    /// 商品现价
    var d_price: String?
    
    /// 商品描述
    var desc: String?
    
    /// 数量
    var amount: Int?
    
    /// 广告大小
    var location: Dictionary<String, Any>?
    
    required init() {}

}
class ProductDetailModel: HandyJSON {
    
    /// 规格
    var sku_list: [Any]?
    
    /// 商品信息
    var goods: Dictionary<String, Any>?
    
    /// 规格
    var sku_gav_list: [Any]?
    
    /// 商品详情
    var detail_url: String?
   
    
    required init() {}
    
}
