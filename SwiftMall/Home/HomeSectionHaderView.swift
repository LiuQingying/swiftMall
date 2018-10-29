//
//  HomeSectionHaderView.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/11.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import Kingfisher

class HomeSectionHaderView: UITableViewHeaderFooterView {
    var adImageView: UIImageView?
    var adModel: AdModel?
    func setModel(model: AdModel) {
        adModel = model
        adImageView?.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.img!)!), placeholder: UIImage.init(named: "YSJJ_rectangleDefaultImage"), options: nil, progressBlock: nil, completionHandler: nil)
    
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        adImageView = UIImageView.init()
        contentView.addSubview(adImageView!)
        adImageView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
