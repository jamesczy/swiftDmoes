//
//  ViewController.swift
//  SnapkitTest
//
//  Created by jamesChen on 2018/12/25.
//  Copyright © 2018年 jamesChen. All rights reserved.
//

import UIKit
import Masonry
import SnapKit
import SwiftyJSON


class ViewController: UIViewController {

    let redView = UIView()
    let blueView = UIView()
    let greenView = UIView()
    let yellowView = UIView()
    
    let textfield = UITextField()
    
    var sendBtn : UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.MasonryTest()
        
        self.SnapKitTest()
        
        
        redView.isUserInteractionEnabled = true
        blueView.isUserInteractionEnabled = true
        
        let tapRedOneClick = UITapGestureRecognizer.init(target: self, action: #selector(oneclick(eventGR: )))
        let tapBlueOneClick = UITapGestureRecognizer.init(target: self, action: #selector(oneclick(eventGR: )))
        let tapGreenOneClick = UITapGestureRecognizer.init(target: self, action: #selector(oneclick(eventGR: )))
        let tapYellowOneClick = UITapGestureRecognizer.init(target: self, action: #selector(oneclick(eventGR:)))
        
        
        redView.addGestureRecognizer(tapRedOneClick)
        blueView.addGestureRecognizer(tapBlueOneClick)
        greenView.addGestureRecognizer(tapGreenOneClick)
        yellowView.addGestureRecognizer(tapYellowOneClick)
    }

    @objc func oneclick(eventGR:UITapGestureRecognizer){
        
        let tableVC = dataTableViewController()
        tableVC.title = "tableView"
        switch eventGR.view {
        case redView:
            tableVC.number = 0
            self.navigationController?.pushViewController(tableVC, animated: true)
        case blueView:
            tableVC.number = 10
            self.navigationController?.pushViewController(tableVC, animated: true)
        case greenView:
            let animationVC = animationViewController()
            self.navigationController?.pushViewController(animationVC, animated: true)
        default:
//            let imageviewVC = ImageShowController()
//            self.navigationController?.pushViewController(imageviewVC, animated: true)
            let categoryVC = MPhoneShellController()
            self.navigationController?.pushViewController(categoryVC, animated: true)
            
            break
        }
        
    }
    
    func SnapKitTest() {
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        
        blueView.backgroundColor = UIColor.blue
        self.view.addSubview(blueView)
        
        greenView.backgroundColor = UIColor.green
        self.view.addSubview(greenView)
        
        yellowView.backgroundColor = UIColor.yellow
        self.view.addSubview(yellowView)
        
        redView.snp.makeConstraints { (maker:ConstraintMaker?) in
            maker?.left.top.equalTo(50)
            maker?.width.height.equalTo(100)
        }
        
        blueView.snp.makeConstraints { (maker:ConstraintMaker?) in
            maker?.left.equalTo(redView.snp_rightMargin).offset(20)
            maker?.top.equalTo(redView)
            maker?.width.height.equalTo(redView)
        }
        
        greenView.snp.makeConstraints { (maker:ConstraintMaker?) in
            maker?.top.equalTo(redView.snp_bottomMargin).offset(20)
            maker?.left.width.height.equalTo(redView)
            
        }
        
        yellowView.snp.makeConstraints { (maker:ConstraintMaker?) in
            maker?.width.height.equalTo(redView)
            maker?.left.equalTo(redView.snp_rightMargin).offset(20)
            maker?.top.equalTo(redView.snp_bottomMargin).offset(20)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = "拥抱安心"
        nameLabel.textColor = UIColor.black
        self.view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (maker:ConstraintMaker?) in
            maker?.left.equalToSuperview().offset(20)
            maker?.right.equalToSuperview().offset(-20)
//            maker?.topMargin.equalTo(greenView.snp_bottomMargin).offset(20)
            maker?.top.equalTo(greenView.snp_bottomMargin).offset(20)
            maker?.height.equalTo(20)
        }
        
        textfield.textColor = UIColor.black
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "请输入发送内容"
        self.view.addSubview(textfield)
        
        textfield.snp.makeConstraints { (maker:ConstraintMaker?) in
            maker?.top.equalTo(nameLabel.snp_bottomMargin).offset(10)
            maker?.left.equalToSuperview().offset(20)
            maker?.right.equalToSuperview().offset(-20)
            maker?.height.equalTo(35)
        }
        
        sendBtn = UIButton(type: .custom)
        sendBtn?.setTitle("发送", for: .normal)
        sendBtn?.setTitleColor(UIColor.black, for: .normal)
        sendBtn?.layer.borderColor = UIColor.black.cgColor
        sendBtn?.layer.borderWidth = 1
        sendBtn?.layer.cornerRadius = 3
        sendBtn?.layer.masksToBounds = true
        sendBtn?.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        self.view.addSubview(sendBtn!)
        
        sendBtn?.snp.makeConstraints({ (maker:ConstraintMaker?) in
            maker?.right.equalTo(textfield)
            maker?.top.equalTo(textfield.snp_bottomMargin).offset(10)
            maker?.height.equalTo(35)
            maker?.width.equalTo(100)
        })
        
        self.userLogin(userId: "111111", userName: "James")
    }
    
    func MasonryTest() {
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        
        blueView.backgroundColor = UIColor.blue
        self.view.addSubview(blueView)
        
        redView.mas_makeConstraints { (maker:MASConstraintMaker?) in
            maker?.top.left()?.equalTo()(50)
            maker?.width.height()?.equalTo()(100)
        }
        
        blueView.mas_makeConstraints { (maker:MASConstraintMaker?) in
            maker?.top.equalTo()(redView)
            maker?.left.equalTo()(redView.mas_right)?.offset()(20)
            maker?.width.height()?.equalTo()(redView)
        }
        self.updateViewConstraints()
    }

    @objc func sendBtnClick(){
        self.view.endEditing(true)
        
        self.postMSG(msg: self.textfield.text ?? "")
        
        self.textfield.text = ""
        
    }
    
    func userLogin(userId:String,userName:String) {
        
        JCNetTool.requestData(requestType: .Post, URLString: "http://api-cn.ronghub.com/user/getToken.json?userId=\(userId)&name=\(userName)", successed: { (isSuccess:Bool?, result:AnyObject?) in
            let Json = JSON(result!)
            print("token = \(Json["token"])")
            
        }) { (isSuccess:Bool?, err:AnyObject?) in
            print(err?.string)
        }
    }
    
    func postMSG(msg:String)  {
        
        var jsonDic = [String:Any]()
        jsonDic["fromUserId"]   = "fromUserId"
        jsonDic["toUserId"]     = "toUserId"
        
        jsonDic["objectName"]   = "objectName"
        jsonDic["content"]      = msg
        
        JCNetTool.requestData(requestType: .Post, URLString: "http://api-cn.ronghub.com/message/private/publish.\(jsonDic)", successed: { (isSuccess:Bool?, result:AnyObject?) in
            let Json = JSON(result!)
            print(Json)
        }) { (isSuccess:Bool?, err:AnyObject?) in
            print(err?.string)
        }
    }
    
    
}

