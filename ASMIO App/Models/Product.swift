//
//  Product.swift
//  ASMIO App
//
//  Created by Mostafa Samir on 06/03/2022.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let type, name: String?
    let urlKey: String?
    let finalPrice, originalPrice, originPrice, shortDescription: String?
    let productDescription: String?
    let images: [Image]?
    let baseImage: BaseImage?
    let variants: [ProductVariation]?
    let inStock: Bool?
    let specifications: [Specification]?
    let reviews: Reviews?
    let isSaved, inCart: Bool?
    let createdAt, updatedAt: String?
    let tags: [String]?
    let cartCount: Int?
    let seller: String?
    let showVat: Bool?
    let discount: String?

    enum CodingKeys: String, CodingKey {
        case id, type, name
        case urlKey = "url_key"
        case finalPrice = "final_price"
        case originalPrice = "original_price"
        case originPrice = "origin_price"
        case shortDescription = "short_description"
        case productDescription = "description"
        case images
        case baseImage = "base_image"
        case variants
        case inStock = "in_stock"
        case specifications, reviews
        case isSaved = "is_saved"
        case inCart = "in_cart"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case tags
        case cartCount = "cart_count"
        case seller
        case showVat = "show_vat"
        case discount
    }
}

// MARK: - ProductVariation
struct ProductVariation: Codable {
    //TODO
}

// MARK: - BaseImage
struct BaseImage: Codable {
    let smallImageURL, mediumImageURL, largeImageURL, originalImageURL: String?

    enum CodingKeys: String, CodingKey {
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case originalImageURL = "original_image_url"
    }
}

// MARK: - Image
struct Image: Codable {
    let id: Int?
    let path: String?
    let url, originalImageURL, smallImageURL, mediumImageURL: String?
    let largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, path, url
        case originalImageURL = "original_image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let total, totalRating: Int?
    let averageRating: Double?
    let percentage: Percentage?
    let topReviews: [TopReview]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalRating = "total_rating"
        case averageRating = "average_rating"
        case percentage
        case topReviews = "top_reviews"
    }
}

// MARK: - Percentage
struct Percentage: Codable {
    let fiveStar, fourStar, threeStar, twoStar: Star?
    let oneStar: Star?

    enum CodingKeys: String, CodingKey {
        case fiveStar = "five_star"
        case fourStar = "four_star"
        case threeStar = "three_star"
        case twoStar = "two_star"
        case oneStar = "one_star"
    }
}

// MARK: - Star
struct Star: Codable {
    let percentage, count: Int?
}

// MARK: - TopReview
struct TopReview: Codable {
    let id: Int?
    let rating, comment, name: String?
    let image: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, rating, comment, name, image
        case createdAt = "created_at"
    }
}

// MARK: - Specification
struct Specification: Codable {
    let key, value: String?
}
