//
//  ImageCollectionViewCell.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with image: Image?) {
        productImageView.setImage(with: image?.mediumImageURL ?? "")
    }
}
