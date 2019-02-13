//
//  ImageShowController.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/24.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation
import SnapKit

class ImageShowController: UIViewController {
    
    var backImageView : UIImageView?
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        
        configImageView()
    }
    
    func configImageView() {
        backImageView = UIImageView.init(image: UIImage.init(named: "timg"))
        backImageView?.contentMode = .scaleAspectFit
        self.view.addSubview(backImageView!)
        
        backImageView?.snp.makeConstraints({ (maker:ConstraintMaker?) in
            maker?.left.right.top.bottom.equalToSuperview()
        })
        
        backImageView?.image = backImageView?.image?.addAlpha(0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let textToShare = "百度"
        let items = [textToShare] as [Any]


        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)

        activityVC.completionWithItemsHandler = {(activity,success,items,err)in
            print(activity)
            print(success)
            print(items)
            print(err)
        }
        self.present(activityVC, animated: true, completion: nil)
    }
}
