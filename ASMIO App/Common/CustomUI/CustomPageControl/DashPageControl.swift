//
//  DashPageControl.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class DashPageControl: UIPageControl {
    
    let preferredImage:UIImage = #imageLiteral(resourceName: "selected")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pageIndicatorTintColor = UIColor.lightTextColor
        self.currentPageIndicatorTintColor = UIColor.yellowColor
        if #available(iOS 14.0, *) {
            self.preferredIndicatorImage = preferredImage
        } else {
            // Fallback on earlier versions
        }
        self.clipsToBounds = false
    }
}
