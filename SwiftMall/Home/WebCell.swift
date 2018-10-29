//
//  WebCell.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/10/9.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
class WebCell: UITableViewCell,WKUIDelegate,WKNavigationDelegate {
    var webView: WKWebView?
    var url: String?
    var height: CGFloat?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        webView = WKWebView.init()
        contentView.addSubview(webView!)
        webView?.snp.makeConstraints({ (make) in
            make.top.equalTo(contentView)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(100).priority(.high)
            make.bottom.equalTo(contentView)

        })
        webView?.scrollView.bounces = false
        webView?.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (height != (self.webView?.scrollView.contentSize.height)!) {
            print(self.webView?.scrollView.contentSize.height as Any)
            height = (self.webView?.scrollView.contentSize.height)!
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshProductDetailWebHeight"), object: nil, userInfo: ["height" : self.webView?.scrollView.contentSize.height ?? 60])
        }

    }
    func setUrl(url: String) {
        self.url = url
        self.webView?.load(URLRequest.init(url: URL.init(string: url)!))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
