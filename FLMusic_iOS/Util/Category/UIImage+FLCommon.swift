//
//  UIImage+FLCommon.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/13.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func coreBlur(inputImage image: UIImage, blurNumber: Double) -> UIImage {
        
        let context = CIContext(options: nil)
        //获取原始图片
        let inputImage =  CIImage(image: image)
        //使用高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //设置模糊半径值（越大越模糊）
        filter.setValue(blurNumber, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: image.size)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        return UIImage(cgImage: cgImage!)
    }
}
