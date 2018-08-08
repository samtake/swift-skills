//
//  STNavController.swift
//  swiftSkills
//
//  Created by huanglongshan on 2018/8/8.
//  Copyright © 2018年 huanglongshan. All rights reserved.
//

import UIKit

class STNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
