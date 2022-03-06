//
//  CategoriesAPIs.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import Foundation

import Alamofire

enum CategoriesPaths {
    static let productsInCategory = "products"
    static let productDetails = "products/get"
    static let relatedProducts = "products/related"
    
}

enum CategoriesApi: Requestable {
    
    case productsInCategory(categoryId: Int)
    case productDetails(productId: Int)
    case relatedProducts(productId: Int)
    
    var path: String {
        switch self {
        case .productsInCategory:
            return CategoriesPaths.productsInCategory
        case .productDetails:
            return CategoriesPaths.productDetails
        case .relatedProducts:
            return CategoriesPaths.relatedProducts
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .productsInCategory:
            return .get
        case .productDetails:
            return .get
        case .relatedProducts:
            return .get
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var urlParameters: Parameters? {
        switch self {
        case .productsInCategory(let categoryId):
            return ["category_id": categoryId]
        case .productDetails(let productId):
            return ["product_id": productId]
        case .relatedProducts(let productId):
            return ["product_id": productId]
        }
    }
}
