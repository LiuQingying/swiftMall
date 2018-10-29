//
//  CategoryCell.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/16.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import Kingfisher
class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgeView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setModel(model: CategoryGoodsModel) {
        self.titleLabel.text = model.name
        self.imgeView.kf.setImage(with: ImageResource.init(downloadURL: NSURL.init(string: model.image!)! as URL), placeholder: UIImage.init(named: "YSJJ_rectangleDefaultImage"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
