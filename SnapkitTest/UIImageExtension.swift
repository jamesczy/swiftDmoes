//
//  UIImageExtension.swift
//  SnapkitTest
//
//  Created by jamesChen on 2019/1/24.
//  Copyright © 2019年 jamesChen. All rights reserved.
//

import Foundation

extension UIImage {
    
    typealias Completion = (_ image: UIImage?) -> ()
    
    /// 生成透明度渐变图片渐变的方向
    ///
    /// - horizontal: 水平方向
    /// - vertical: 竖直方向
    enum AlphaGradientDirection: Int {
        case horizontal
        case vertical
    }
    
    /// 设置图片渐变的透明度 这个方法性能 有待商榷 自己感觉这种做法有点蠢 但暂时没有找到更合适的方法
    ///
    /// - Parameters:
    ///   - direction: 透明度渐变方向 默认 .horizontal
    ///   - from: 起始透明度 （0-1）  默认 1
    ///   - to:   结束透明度（0-1）   默认 0
    ///   - completion: 图片处理结果
    func addGradientAlpha(
        _ direction: AlphaGradientDirection = .horizontal,
        from: CGFloat = 1,
        to: CGFloat = 0,
        scale: CGFloat = UIScreen.main.scale,
        completion: @escaping Completion)
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let contenxt = UIGraphicsGetCurrentContext() else {
            completion(nil)
            UIGraphicsEndImageContext()
            return
        }
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        contenxt.scaleBy(x: 1, y: -1)
        contenxt.translateBy(x: 0, y: -rect.height)
        contenxt.setBlendMode(.multiply)
        
        let width: CGFloat = 1
        let max = Int(((direction == .horizontal) ? size.width: size.height) / width)
        let gradient = (to - from) / CGFloat(max)
        var gradientRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        switch direction {
        case .horizontal:
            gradientRect.size.height = size.height
            gradientRect.size.width = width
        case .vertical:
            gradientRect.size.width = size.width
            gradientRect.size.height = width
        }
        
        let group = DispatchGroup()
        let lock = DispatchSemaphore(value: 1)
        var selfImage: UIImage? = self
        for i in 0..<max {
            let tRect = gradientRect
            let alpha = from + CGFloat(i) * gradient
            DispatchQueue.global(qos: .background).async(
                group: group,
                qos: .background,
                flags: [],
                execute:
                {
                    if let image = selfImage?.imageFromRect(tRect, scale: scale)?.cgImage {
                        lock.wait()
                        contenxt.setAlpha(alpha)
                        contenxt.draw(image, in: tRect)
                        lock.signal()
                    }
            })
            
            switch direction {
            case .horizontal: gradientRect.origin.x = gradientRect.origin.x + width
            case .vertical: gradientRect.origin.y = gradientRect.origin.y + width
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            selfImage = nil
            let image = UIGraphicsGetImageFromCurrentImageContext()
            completion(image)
            UIGraphicsEndImageContext()
        }
    }
    
    /// 设置图片透明度
    ///
    /// - Parameter alpha: 透明度
    /// - Returns: 处理后图片
    func addAlpha(_ alpha: CGFloat) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let contenxt = UIGraphicsGetCurrentContext() else { return nil }
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        contenxt.scaleBy(x: 1, y: -1)
        contenxt.translateBy(x: 0, y: -rect.height)
        contenxt.setBlendMode(.multiply)
        contenxt.setAlpha(alpha)
        contenxt.draw(cgImage, in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    /// 从指定位置获取新的图片
    ///
    /// - Parameters:
    ///   - rect: 获取新图片的位置
    ///   - scale: 图片缩放比例
    /// - Returns: 处理后图片
    func imageFromRect(_ rect: CGRect, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let x = rect.origin.x * scale
        let y = rect.origin.y * scale
        let w = rect.size.width * scale
        let h = rect.size.height * scale
        let rect = CGRect(x: x, y: y, width: w, height: h)
        
        guard
            let cgImage = cgImage,
            let newCGImage = cgImage.cropping(to: rect)
            else { return nil }
        
        return UIImage(cgImage: newCGImage, scale: scale, orientation: UIImage.Orientation.up)
    }
}
