//
//  CategoryHeaderView.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/17.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit

class CategoryHeaderView: UICollectionReusableView {
    var titleLabel = UILabel.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        titleLabel.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
