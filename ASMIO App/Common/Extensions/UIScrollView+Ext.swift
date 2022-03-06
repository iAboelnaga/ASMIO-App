//
//  UIScrollView+Ext.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

enum ScrollDirection {
    case top
    case right
    case bottom
    case left
    
    func contentOffsetWith(scrollView: UIScrollView) -> CGPoint {
        var contentOffset = CGPoint.zero
        switch self {
            case .top:
                contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
            case .right:
                contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
            case .bottom:
                contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height)
            case .left:
                contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
        }
        return contentOffset
    }
}

extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}
