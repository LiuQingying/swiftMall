//
//  HomeGoodsCell.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/9/15.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
typealias clickBtn = (String) ->()
@objc protocol HomeGoodsCellDelgate: NSObjectProtocol {
  @objc optional  func homeGoodsCell(goodsCell: HomeGoodsCell)

}
class HomeGoodsCell: UITableViewCell {
    var goodsPictureImageView: UIImageView?
    lazy var titleLabel = UILabel()
    var priceLabel: UILabel?
    var clickButton: clickBtn?
    var delegate: HomeGoodsCellDelgate?
    var _model: GoodsModel?
    func setModel(model: GoodsModel) {
        _model = model
        titleLabel.text = model.title
        priceLabel?.text = model.d_price
        
        goodsPictureImageView?.kf.setImage(with: ImageResource(downloadURL: URL.init(string: model.main_pic!)!), placeholder: UIImage.init(named: "YSJJ_rectangleDefaultImage"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSuvViews()
        _ = self.rx.observe(CGRect.self, "frame")
            
            .subscribe(onNext: { (frame) in
                
                
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }) {
                
        }
        
    }
    private func setupSuvViews() {
        goodsPictureImageView = UIImageView.init(frame: CGRect.init(origin: CGPoint.init(x: 5, y: 5), size: CGSize.init(width: 50, height: 50)))
        goodsPictureImageView?.backgroundColor = UIColor.lightGray
        goodsPictureImageView?.isUserInteractionEnabled = true
        self.contentView.addSubview(goodsPictureImageView!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapPicture))
        goodsPictureImageView?.addGestureRecognizer(tap)
        titleLabel.frame = CGRect.init(x: 60, y: 7, width: kScreenWidth-65, height: 20)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel)
        priceLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(65)
            make.right.equalTo(-10)
            make.top.equalTo(7)
        })
        priceLabel = UILabel()
        priceLabel?.textColor = UIColor.red
        priceLabel?.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(priceLabel!)
        priceLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        })
        let btn: UIButton = UIButton.init()
        
        
        
    }
    @objc func tapPicture() {
        if (clickButton != nil) {
            clickButton!("hahha")
        }
        if (delegate != nil) {
            delegate?.homeGoodsCell!(goodsCell: self)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
