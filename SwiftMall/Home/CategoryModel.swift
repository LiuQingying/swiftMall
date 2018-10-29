//
//  CategoryModel.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/16.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import HandyJSON
struct CategoryModel: HandyJSON {
    var name: String?
    var menu = [CategorySubModel]()
    var pid: String?
    var lev: String?
    var id: String?
    var image: String?
}
struct CategorySubModel: HandyJSON {
    var name: String?
    var menu = [CategoryGoodsModel]()
    var pid: String?
    var lev: String?
    var id: String?
    var image: String?

}
struct CategoryGoodsModel: HandyJSON {
    var name: String?
    var pid: String?
    var lev: String?
    var id: String?
    var image: String?
    
}
