//
//  MyTabBarController.swift
//  SwiftMall
//
//  Created by LiuQingying on 2018/9/15.
//  Copyright © 2018年 JM. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }
    func addChildViewControllers() {
        setChildViewControllers(childViewController: HomeViewController(), title: "首页", imageName: "home_normal", selectImageName: "home_highlight")
        setChildViewControllers(childViewController: FenLeiViewController(), title: "分类", imageName: "fenlei_normal", selectImageName: "fenlei_highlight")
    }
    func setChildViewControllers(childViewController: UIViewController, title: String, imageName: String, selectImageName: String) {
        childViewController.title = title
        childViewController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for:UIControlState.normal)
        childViewController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], for:UIControlState.selected)
        childViewController.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childViewController.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        addChildViewController(MyNavigationViewController(rootViewController: childViewController))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
