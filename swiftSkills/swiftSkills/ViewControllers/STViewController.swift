//
//  STViewController.swift
//  swiftSkills
//
//  Created by huanglongshan on 2018/8/8.
//  Copyright © 2018年 huanglongshan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class STViewController: UIViewController ,UITextFieldDelegate,NVActivityIndicatorViewable {
    //    let window = UIApplication.shared.keyWindow!
    // MARK: - 生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(hex: 0xF6F6F6)
        
        setStatusBarBackgroundColor(color: UIColor(hex: 0x00bc70))
        
        automaticallyAdjustsScrollViewInsets = false
        
        navigationController?.isNavigationBarHidden = true
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addNotification()
        
        makeNav()
        
        makeUI()
        
        makeData()
        
    }
    
    // MARK: - 函数
    func makeNav() -> Void {
        
        _ = navView
        _ = titleLabel
        _ = backButton
        
    }
    
    func makeUI() -> Void {
        
    }
    
    func makeData() -> Void {
        //默认
        
    }
    func addNotification() -> Void {
        //非必要
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func backButtonClick(button:UIButton) -> Void {
        
        navigationController?.popViewController(animated: false)
        
    }
    @objc func leftButtonClick(button:UIButton) -> Void {
        
    }
    @objc func rightButtonClick(button:UIButton) -> Void {
        button.isSelected = !button.isSelected
    }
    // MARK: titleLabel 设置方法
    func setTitle(title:NSString) -> Void {
        
        titleLabel.text = title as String
        
    }
    
    func setTitleColor(color:UIColor) -> Void {
        
        titleLabel.textColor = color
        
    }
    
    func setTitleFont(font:UIFont) -> Void {
        
        titleLabel.font = font
        
    }
    
    // MARK: navView 设置方法
    func setNavViewColor(color:UIColor) -> Void {
        
        navView.backgroundColor = color
        
    }
    // MARK: backButton 方法
    func setbackButtonHide(hide:Bool) -> Void {
        
        backButton.isHidden = hide
        
    }
    
    // MARK: - 懒加载
    lazy var navView: UIView = {
        
        var navView = UIView()
        self.view.addSubview(navView)
        
        navView.backgroundColor = UIColor(hex: 0x13ca80)
        navView.snp.makeConstraints({ (make) in
            make.width.left.equalTo(self.view)
            make.top.equalTo(20)
            make.height.equalTo(44)
        })
        
        return navView
        
    }()
    
    lazy var titleLabel: UILabel = {
        
        var titleLabel = UILabel()
        navView.addSubview(titleLabel)
        //titleLabel.text = "标题"
        titleLabel.font = kFont(F: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(navView)
            make.top.equalTo(navView).offset(kHight(h: 30))
        })
        
        return titleLabel
        
    }()
    
    lazy var backButton: UIButton = {
        
        var backButton = UIButton()
        navView.addSubview(backButton)
        
        backButton.setImage(UIImage(named: "return"), for: .normal)
        backButton.contentHorizontalAlignment = .left;
        backButton.addTarget(self, action: #selector(backButtonClick(button:)), for: .touchUpInside)
        
        backButton.snp.makeConstraints({ (make) in
            make.width.equalTo(kWidth(w: 50))
            make.height.equalTo(kHight(h: 44))
            make.left.equalTo(navView).offset(kWidth(w: 20))
            make.top.equalTo(kHight(h: 30))
        })
        
        return backButton
        
    }()
    lazy var leftButton: UIButton = {
        
        var leftButton = UIButton()
        navView.addSubview(leftButton)
        
        leftButton.titleLabel?.font = .systemFont(ofSize: 12)
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        leftButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonClick(button:)), for: .touchUpInside)
        leftButton.snp.makeConstraints({ (make) in
            make.left.equalTo(navView).offset(kWidth(w: 20))
            make.right.lessThanOrEqualTo(titleLabel.snp.left).offset(kWidth(w: -20))
            make.height.equalTo(kHight(h: 44))
            make.top.equalTo(kHight(h: 30))
        })
        
        return leftButton
        
    }()
    lazy var rightButton: UIButton = {
        
        var rightButton = UIButton()
        navView.addSubview(rightButton)
        
        rightButton.titleLabel?.font = .systemFont(ofSize: 12)
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButton.setTitleColor(UIColor(hex: 0xffffff), for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonClick(button:)), for: .touchUpInside)
        rightButton.snp.makeConstraints({ (make) in
            make.right.equalTo(navView).offset(kWidth(w: -20))
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(kWidth(w: 20))
            make.height.equalTo(kHight(h: 44))
            make.top.equalTo(kHight(h: 30))
        })
        
        return rightButton
        
    }()
    lazy var HUD: NVActivityIndicatorView = {
        
        let HUD = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: kWidth(w: 100), height: kHight(h: 100)), type: .lineSpinFadeLoader, color: UIColor(hex: 0x00bc70), padding: 0.5)
        HUD.center = view.center
        
        self.view.addSubview(HUD)
        return HUD
    }()
    // MARK: - 设置
    // 设置状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        get { return.lightContent}
        
    }
    
    // 设置状态栏背景颜色
    func setStatusBarBackgroundColor(color : UIColor) {
        
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        /*
         if statusBar.responds(to:Selector("setBackgroundColor:")) {
         statusBar.backgroundColor = color
         }*/
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
        
    }
    
    //点击return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    //点击其他地方  收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
        
}
