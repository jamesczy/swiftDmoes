//
//  MPhoneShellController.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/28.
//  Copyright © 2019年 jamesChen. All rights reserved.
//  给图片添加手机外观样式

import Foundation


class MPhoneShellController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var categoryCollection : UICollectionView?
    
    let phoneView = PhoneAppearanceView()
    
    var phoneCategoryArray = Array<String>()
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        phoneCategoryArray = ["iPhone5s黑",
                              "iPhone5s",
                              "iPhone5s金",
                              "iPhone6s黑",
                              "iPhone6s白",
                              "iPhone6s金",
                              "iPhone6s粉",
                              "iPhone6sp黑",
                              "iPhone6sp白",
                              "iPhone6sp金",
                              "iPhone6sp粉",
                              "iPhoneX黑"]
        
        self.setUpCollection()
        
        self.contentAppearanceView()
    }
    
    func setUpCollection() {
        
        let categoryFrame = CGRect(x: 0, y: screenH - 150, width: screenW, height: 150)
        
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        
        categoryLayout.itemSize = CGSize(width: 100, height: 130)
        
        categoryCollection = UICollectionView.init(frame: categoryFrame, collectionViewLayout: categoryLayout)
        
        categoryCollection?.register(PhoneCollectionCell.self, forCellWithReuseIdentifier: "normalCell")
        categoryCollection?.backgroundColor = UIColor.lightGray
        categoryCollection?.delegate = self
        categoryCollection?.dataSource = self
        self.view.addSubview(categoryCollection!)
    }
    
    func contentAppearanceView() {
        
        self.view.addSubview(phoneView)
        phoneView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.view.snp_leftMargin).offset(20)
            maker.right.equalTo(self.view.snp_rightMargin).offset(-20)
            maker.top.equalTo(self.view.snp_topMargin).offset(0)
            maker.bottom.equalTo((self.categoryCollection?.snp_topMargin)!).offset(-10)
        }
        phoneView.phoneCategory = "iPhone5s"
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.phoneCategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normalCell", for: indexPath) as! PhoneCollectionCell
        cell.backgroundColor = UIColor.yellow
        cell.phoneCategory = self.phoneCategoryArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.phoneView.phoneCategory = self.phoneCategoryArray[indexPath.row]
    }
}
