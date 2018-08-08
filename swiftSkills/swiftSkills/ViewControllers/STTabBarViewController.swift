//
//  STTabBarViewController.swift
//  swiftSkills
//
//  Created by huanglongshan on 2018/8/8.
//  Copyright © 2018年 huanglongshan. All rights reserved.
//

import UIKit

class STTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let vcs : Array<STViewController> = [STFunctionalViewController(),STFunctionalViewController(),STFunctionalViewController(),STFunctionalViewController(),STFunctionalViewController()]
        let titles : Array<NSString> = ["函数式编程","函数式编程","函数式编程","函数式编程","函数式编程"]
        let normalImgs : Array<NSString> = ["geren1","geren1","geren1","geren1","geren1"]
        let selectImgs : Array<NSString> = ["geren2","geren2","geren2","geren2","geren2"]
        for (i,title) in titles.enumerated() {
            addChildVCToNavC(childVC: vcs[i], title: title, image: UIImage(named: normalImgs[i] as String)!, selectImage: UIImage(named: selectImgs[i] as String)!)
        }
        
        tabBar.isTranslucent = false
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor: UIColor(hex: 0x666666)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor: UIColor(hex: 0x13ca80)], for:.selected)
        
    }
    func addChildVCToNavC(childVC:STViewController,title:NSString,image:UIImage,selectImage:UIImage) -> Void {
        
        childVC.title = title as String
        /* iOS >= 7.0 */
        childVC.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        
        childVC.tabBarItem.selectedImage = selectImage.withRenderingMode(.alwaysOriginal)
        
        // 添加导航控制器
        
        addChildViewController(STNavController(rootViewController: childVC))
    }
        
}
