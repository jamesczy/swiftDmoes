//
//  PhoneCollectionCell.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/28.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation


class PhoneCollectionCell: UICollectionViewCell {
    
    
    var categoryLabel : UILabel?
    
    var categoryImgView : UIImageView?
    
    var phoneCategory : String?{
        didSet{
            categoryImgView?.image = UIImage.init(named: phoneCategory ?? "" )
            categoryLabel?.text = phoneCategory
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        categoryImgView = UIImageView()
        categoryImgView?.backgroundColor = UIColor.black
        self.addSubview(categoryImgView!)
        
        categoryLabel = UILabel()
        categoryLabel?.textColor = UIColor.white
        categoryLabel?.textAlignment = .center
        self.addSubview(categoryLabel!)
        
        categoryImgView?.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        
        categoryLabel?.snp.makeConstraints({ (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.greaterThanOrEqualToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
