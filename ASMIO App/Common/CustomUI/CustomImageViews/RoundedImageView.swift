//
//  RoundedImageView.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
