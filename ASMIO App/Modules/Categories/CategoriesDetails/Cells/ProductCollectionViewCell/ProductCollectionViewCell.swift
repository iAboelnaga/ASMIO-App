//
//  ProductCollectionViewCell.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var productImageView: RoundedImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var optionsView: RoundedView!
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productFinalPriceLabel: UILabel!
    @IBOutlet weak var productOriginalPriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var isFavorite = false
    var canAddToCart = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with product: Product) {
        
        //check if product is in wishlist or not
        if product.isSaved ?? false {
            isFavorite = true
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }else {
            isFavorite = false
            favoriteButton.setImage(#imageLiteral(resourceName: "not-favorite"), for: .normal)
        }
        //check if product is in the cart or not
        if product.inCart ?? false {
            addToCartButton.setImage(#imageLiteral(resourceName: "in-cart"), for: .normal)
        }else {
            addToCartButton.setImage(#imageLiteral(resourceName: "Cart-Icon"), for: .normal)
        }
        //check if product have a discount or not
        if let discount = product.discount,
           !discount.isEmpty {
                discountPercentageLabel.isHidden = false
                productOriginalPriceLabel.isHidden = false
                productOriginalPriceLabel.attributedText = product.originalPrice?.strikeThrough()
        }else {
            discountPercentageLabel.isHidden = true
            productOriginalPriceLabel.isHidden = true
        }
        
        productImageView.setImage(with: product.baseImage?.mediumImageURL ?? "")
        productNameLabel.text = product.name
        productFinalPriceLabel.text = product.finalPrice?.dropFirst(4).description
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        isFavorite.toggle()
        if isFavorite {
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }else {
            favoriteButton.setImage(#imageLiteral(resourceName: "not-favorite"), for: .normal)
        }
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        canAddToCart.toggle()
        if canAddToCart {
            addToCartButton.setImage(#imageLiteral(resourceName: "in-cart"), for: .normal)
        }else {
            addToCartButton.setImage(#imageLiteral(resourceName: "Cart-Icon"), for: .normal)
        }
    }
    
}
