//
//  Extension+UITableView.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/2.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {
    
    /// 类方法实现runtime的方法交换,处理tableview没有数据时的背景图
    public class func initializeMethod() {
        
        let originalSelector = #selector(UITableView.reloadData)
        let swizzledSelector = #selector(jc_reloadData)
        
        //  runtime获取函数方法
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        //  判断是否实现了上面获取的方法
//        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
//
//        if didAddMethod {
//            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
//        } else {
//        }
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
        
    }
    
    @objc func jc_reloadData(){
        self.jc_reloadData()
        
        let number = self.numberOfSections
        var havingData = false
        
        for i in 0..<number {
            if self.numberOfRows(inSection: i) > 0{
                havingData = true
                break
            }
        }
        
        if havingData {
            self.backgroundView = UIImageView()
        }else{
            self.backgroundView = UIImageView.init(image: UIImage.init(named: "drawing_no_duty"))
            self.backgroundView?.contentMode = .center
        }
    }
}
