//
//  productDetailCell.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/6.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {
    var titleLabel: UILabel?
    var descLabel: UILabel?
    var priceLabel: UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    private func setupSubviews() {
        titleLabel = UILabel.init()
        titleLabel?.numberOfLines = 0;
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(titleLabel!);
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(-15)
            make.top.equalTo(15)
        })
        descLabel = UILabel.init()
        descLabel?.numberOfLines = 0;
        descLabel?.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(descLabel!);
        descLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.right.equalTo(titleLabel!);
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(5)
        })
        priceLabel = UILabel.init()
        priceLabel?.textColor = UIColor.red
        priceLabel?.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(priceLabel!);
        priceLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.top.equalTo((descLabel?.snp.bottom)!).offset(5)
            make.bottom.equalTo(contentView).offset(-10)

        })
    }
    func setData(goods: Dictionary<String,Any>) {
        titleLabel?.text = goods["title"] as? String
        descLabel?.text =  goods["desc"] as? String
        priceLabel?.text = goods["d_price"] as? String
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
