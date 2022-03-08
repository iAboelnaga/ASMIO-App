//
//  UIImage+Ext.swift
//  ASMIO App
//
//  Created by Mostafa Samir on 06/03/2022.
//

import UIKit

extension UIImage {
    
        func imageWithColor(tintColor: UIColor) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0);
            context.setBlendMode(.normal)

            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
            context.clip(to: rect, mask: self.cgImage!)
            tintColor.setFill()
            context.fill(rect)

            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            return newImage
        }
    }
