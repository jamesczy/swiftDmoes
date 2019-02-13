//
//  JCNetTool.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/8.
//  Copyright © 2019年 jamesChen. All rights reserved.
//  对网络请求的封装

import Foundation
import SwiftyJSON
import Alamofire

enum RequestType {
    case Get
    
    case Post
    
    case Put
    
    case Delete
}

typealias complete = (Bool?,AnyObject?)->Void


class JCNetTool {
    static let manage:SessionManager = {
        var defHeards = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]
        let defConf = URLSessionConfiguration.default
        
        defConf.timeoutIntervalForRequest = 10
        defConf.httpAdditionalHeaders = defHeards
        
        return Alamofire.SessionManager(configuration: defConf, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }()
}

extension JCNetTool {
    
    static func requestData(requestType : RequestType,URLString : String,parameters : [String:Any]? = nil , successed : @escaping complete,failured:@escaping complete){
        
        
        //获取请求类型
        var method : HTTPMethod?
        
        switch requestType {
        case .Get:
            method = HTTPMethod.get
        case .Post:
            method = HTTPMethod.post
        case .Put:
            method = HTTPMethod.put
        case .Delete:
            method = HTTPMethod.delete
            
        }
        //当前时间的时间戳
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let headers:HTTPHeaders = [
            "App-Key"           : rongCouldAppKey,
            "Nonce"             : "\(timeStamp)",
            "Signature"         : "SHA1算法签名"
        ]
        //发送网络请求
        Alamofire.request(URLString, method: method!, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            //获取返回结果
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value as Any)
                if json["Code"] == "118004"{
                    print("登陆过期")
   
                }else{
                    successed(true, response.result.value as AnyObject)
                    
                }
            case .failure:
                failured(false, "连接服务器失败" as AnyObject)
            }
            
        }
    }
 
}
