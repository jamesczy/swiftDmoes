//
//  PhoneAppearanceView.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/28.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation

class PhoneAppearanceView: UIView {
    
    var phoneImgView : UIImageView?
    
    var phoneCategory : String?{
        didSet{
            phoneImgView?.image = UIImage.init(named: phoneCategory!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        phoneImgView = UIImageView()
        phoneImgView?.backgroundColor = UIColor.black
        phoneImgView?.contentMode = .scaleAspectFit
        phoneImgView?.clipsToBounds = true
        self.addSubview(phoneImgView!)
        
        phoneImgView?.snp.makeConstraints({ (maker) in
            maker.left.right.top.bottom.equalToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
