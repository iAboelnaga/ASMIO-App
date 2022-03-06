//
//  CircleImageView.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
    }
}
