//
//  UIView+Ext.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

extension UIView{
    func animateRotation(){
        UIView.animate(withDuration:0.5, animations: { () -> Void in
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }else{
                self.transform = .identity
            }
        })
    }
    
    func toImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
}
