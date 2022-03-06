//
//  UIImage+Ext.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import SDWebImage

extension UIImageView {
    
    func setImage(with url: String) {
        
        self.sd_cancelCurrentImageLoad()
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: nil, options: [.scaleDownLargeImages, .retryFailed], context: [:])
    }
}
