//
//  animationViewController.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/14.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height


class animationViewController: UIViewController {
    
    var tipLabel : UILabel?
    
    var seconedLabel : UILabel?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        self.setupUI()
        
        self.configAnimation()
        
        self.beginAnimation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func setupUI() {
        tipLabel = UILabel()
        tipLabel?.text = "自由也是分级的:先是财务自由，再是思想自由，最后才能步伐自由。"
        tipLabel?.textColor = UIColor.red
        tipLabel?.textAlignment = .left
        tipLabel?.font = UIFont.systemFont(ofSize: 17)
        tipLabel?.frame = CGRect.init(x: 0, y: 120, width: screenW, height: 50)
        self.view.addSubview(tipLabel!)
        
        seconedLabel = UILabel()
        seconedLabel?.text = "自由也是分级的:先是财务自由，再是思想自由，最后才能步伐自由。"
        seconedLabel?.textColor = UIColor.green
        seconedLabel?.textAlignment = .left
        seconedLabel?.font = UIFont.systemFont(ofSize: 17)
        seconedLabel?.frame = CGRect.init(x: screenW, y: 120, width: screenW, height: 50)
        self.view.addSubview(seconedLabel!)
    }
    
    func configAnimation() {
        
        //  跑马灯动画
//        var frame = tipLabel?.frame
//        frame?.origin.x = screenW
//        tipLabel?.frame = frame!
//
//        UIView.beginAnimations("testAnimation", context: nil)
//        UIView.setAnimationDuration(3.0)
//        UIView.setAnimationCurve(UIView.AnimationCurve.linear)
//        UIView.setAnimationDelegate(self)
//        UIView.setAnimationRepeatAutoreverses(false)
//        UIView.setAnimationRepeatCount(100)
//
//        frame = tipLabel?.frame
//        frame?.origin.x = -screenW
//        tipLabel?.frame = frame!
//
//        UIView.commitAnimations()
        
        //  跑马灯动画
//        UIView.animate(withDuration: 3, delay: 0, options: UIView.AnimationOptions(rawValue: UIView.AnimationOptions.repeat.rawValue|UIView.AnimationOptions.curveLinear.rawValue), animations: {
//            self.tipLabel?.transform = CGAffineTransform(translationX: -(2 * screenW),y: 0)
//        }, completion: nil)
        
        
        // 跑马灯动画 此方法能实现app进入后台在返回前端还能继续运行
        let anim = CABasicAnimation()
        anim.keyPath = "position"
        anim.fromValue = NSValue.init(cgPoint:CGPoint(x: (self.tipLabel?.frame.width)! / 2, y: (self.tipLabel?.frame.origin.y)! + (self.tipLabel?.frame.height)! / 2))
        anim.toValue = NSValue(cgPoint: CGPoint(x: -1 * (self.tipLabel?.frame.width)! / 2, y: (self.tipLabel?.frame.origin.y)! + (self.tipLabel?.frame.height)! / 2))
        anim.duration = 3
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        anim.repeatCount = MAXFLOAT


        let seconedAnim = CABasicAnimation()
        seconedAnim.keyPath = "position"
        seconedAnim.fromValue = NSValue.init(cgPoint:CGPoint(x: (self.tipLabel?.frame.width)! / 2 * 3, y:  (self.tipLabel?.frame.origin.y)! + (self.tipLabel?.frame.height)! / 2))
        seconedAnim.toValue = NSValue(cgPoint: CGPoint(x: (self.tipLabel?.frame.width)! / 2, y: (self.tipLabel?.frame.origin.y)! + (self.tipLabel?.frame.height)! / 2))
        seconedAnim.duration = 3
        seconedAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        seconedAnim.repeatCount = MAXFLOAT

        self.tipLabel?.layer.add(anim, forKey: "firstAnim")
        self.seconedLabel?.layer.add(seconedAnim, forKey: "seconedAnim")

        anim.isRemovedOnCompletion = false
        seconedAnim.isRemovedOnCompletion = false


    }
    
    func beginAnimation() {
        tipLabel?.layer.timeOffset = 0
        tipLabel?.layer.speed = 1.0
        tipLabel?.layer.beginTime = 0
        
        seconedLabel?.layer.timeOffset = 0
        seconedLabel?.layer.speed = 1.0
        seconedLabel?.layer.beginTime = 0
    }
    
    @objc func enterBackground(){
        let pauseTime = self.tipLabel?.layer.convertTime(CACurrentMediaTime(), to: nil)
        self.tipLabel?.layer.speed = 0
        self.tipLabel?.layer.timeOffset = pauseTime!
        
    }
    
    @objc func becomeActive(){
        self.configAnimation()
        let pauseTime = self.tipLabel?.layer.timeOffset
        self.tipLabel?.layer.speed = 1
        self.tipLabel?.layer.timeOffset = 0
        self.tipLabel?.layer.beginTime = 0
        let timeSincePause = Double((self.tipLabel?.layer.convertTime(CACurrentMediaTime(), from: nil))!) - Double(pauseTime!)
        
        self.seconedLabel?.layer.speed = 1
        self.seconedLabel?.layer.timeOffset = 0
        self.seconedLabel?.layer.beginTime = 0
        self.tipLabel?.layer.beginTime = timeSincePause
        self.seconedLabel?.layer.beginTime = timeSincePause
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.view.layer.removeAllAnimations()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}
