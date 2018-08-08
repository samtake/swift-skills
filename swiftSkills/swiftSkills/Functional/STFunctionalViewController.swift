//
//  STFunctionalViewController.swift
//  swiftSkills
//
//  Created by huanglongshan on 2018/8/8.
//  Copyright © 2018年 huanglongshan. All rights reserved.
//

import UIKit
import SwiftyJSON

class STFunctionalViewController : STViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: 👉 入口自动调用makeNav()->makeUI()->makeData()
    override func makeNav() -> Void {
        super.makeNav()
    }
    override func makeUI() -> Void {
        super.makeUI()
    }
    override func makeData() -> Void {
        super.makeData()
        _ = tableView
    }
    // MARK: 👉 点击方法
    @objc func loginButtonClick(button:UIButton) -> Void {
    }
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = kWidth(w: 120)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(self.view)
        })
        
        return tableView
        
    }()
}

extension STFunctionalViewController : UITableViewDelegate,UITableViewDataSource{
    // MARK: 👉 UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell  = tableView.dequeueReusableCell(withIdentifier: "bankCell") as? STBankCardCell
            if cell == nil {
                cell = STBankCardCell(style: .subtitle, reuseIdentifier: "bankCell")
                cell?.selectionStyle = .none
                cell?.backgroundColor = UIColor.white
            }
            cell?.cellJson = JSON(["select":true,"image":"weixinzhifu","name":"微信支付","detail":""])
            return cell!
        } else if indexPath.row == 1 {
            var cell  = tableView.dequeueReusableCell(withIdentifier: "bankCell") as? STBankCardCell
            if cell == nil {
                cell = STBankCardCell(style: .subtitle, reuseIdentifier: "bankCell")
                cell?.selectionStyle = .none
                cell?.backgroundColor = UIColor.white
            }
            cell?.cellJson = JSON(["select":true,"image":"zhifubaozhifu","name":"支付宝支付","detail":""])
            return cell!
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHight(h: 80)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHight(h: 80)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let button = UIButton(type: UIButtonType.custom)
        headerView.addSubview(button)
        button.setImage(UIImage(named:"cha"), for: UIControlState.normal)
        button.setTitleColor(UIColor(hex: 0x333333), for: UIControlState.normal)
        button.addTarget(self, action: #selector(cancelButtonClick(button:)), for: UIControlEvents.touchUpInside)
        button.snp.makeConstraints({ (make) in
            make.width.height.equalTo(kWidth(w: 60))
            make.left.equalTo(kWidth(w: 20))
            make.centerY.equalTo(headerView)
        })
        let titleLabel = UILabel()
        headerView.addSubview(titleLabel)
        titleLabel.text = "swift 函数式编程学习"
        titleLabel.textColor = UIColor(hex:0x333333)
        titleLabel.font = kFont(F: 15)
        titleLabel.snp.makeConstraints({ (make) in
            make.center.equalTo(headerView)
        })
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let button = UIButton(type: UIButtonType.custom)
        footerView.addSubview(button)
        //button.setTitle("取消", for: UIControlState.normal)
        button.titleLabel?.font = kFont(F: 15)
        button.backgroundColor = UIColor(hex: 0xeeeeee)
        button.setTitleColor(UIColor(hex: 0x333333), for: UIControlState.normal)
        button.addTarget(self, action: #selector(cancelButtonClick(button:)), for: UIControlEvents.touchUpInside)
        button.snp.makeConstraints({ (make) in
            make.left.width.bottom.height.equalTo(footerView)
        })
        return footerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if (didPopCellBlock != nil) {
//            removeFromSuperview()
//            didPopCellBlock!(indexPath.row)
//        }
    }
    
    @objc func cancelButtonClick(button:UIButton) -> Void {
        //removeFromSuperview()
    }
}



// MARK: 👉 STBankCardCell
class STBankCardCell: UITableViewCell {
    var cellJson :JSON!{
        didSet{
            //leftImgView.image = UIImage(named: cellJson["image"].stringValue)
            nameLabel.text = cellJson["name"].stringValue
            detailLabel.text = cellJson["detail"].stringValue
            selectButton.isHidden = cellJson["select"].boolValue
        }
    }
    override func draw(_ rect: CGRect) {
        _ = leftImgView
        _ = nameLabel
        _ = detailLabel
        _ = selectButton
    }
    lazy var leftImgView: UIImageView = {
        var leftImgView = UIImageView()
        addSubview(leftImgView)
        //        leftImgView.layer.masksToBounds = true
        //        leftImgView.layer.cornerRadius = kWidth(w: 35)
        leftImgView.snp.makeConstraints({ (make) in
            make.left.equalTo(kWidth(w: 20))
            make.centerY.equalTo(self)
            make.height.width.equalTo(kHight(h: 70))
        })
        return leftImgView
    }()
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        addSubview(label)
        label.textColor = UIColor(hex: 0x333333)
        label.font = kFont(F: 12)
        label.snp.makeConstraints({ (make) in
            make.left.equalTo(leftImgView.snp.right).offset(kWidth(w: 20))
            make.top.equalTo(leftImgView)
        })
        return label
    }()
    lazy var detailLabel: UILabel = {
        var label = UILabel()
        addSubview(label)
        label.textColor = UIColor(hex: 0x666666)
        label.font = kFont(F: 10)
        label.snp.makeConstraints({ (make) in
            make.left.equalTo(leftImgView.snp.right).offset(kWidth(w: 20))
            make.bottom.equalTo(leftImgView)
        })
        return label
    }()
    lazy var selectButton: UIButton = {
        var button = UIButton()
        addSubview(button)
        button.adjustsImageWhenHighlighted = false
        //button.setImage(UIImage(named:"xuanzhongc"), for: UIControlState.normal)
        button.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(kWidth(w: -20))
            make.centerY.equalTo(self)
        })
        return button
    }()
}












