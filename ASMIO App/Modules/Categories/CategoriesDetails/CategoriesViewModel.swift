//
//  CategoriesViewModel.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import Foundation

class CategoriesViewModel: BaseViewModel {
    
private var products = [Product]() {
    didSet {
        applySorting()
    }
}
private(set) var sortedProducts = [Product]()
private let categoryID = 16
var reloadData: (() -> Void)?
var sortingOption: SortOptions = .popularity {
    didSet {
        applySorting()
        reloadData?()
    }
}

func fetchProducts() {
    startRequest(request: CategoriesApi.productsInCategory(categoryId: categoryID), mappingClass: ResponseModel<[Product]>.self) { [weak self] response in
        self?.products.append(contentsOf: response?.data ?? [])
        self?.reloadData?()
    }
}

func applySorting() {
    
    switch sortingOption {
    case .popularity:
        sortedProducts = products
    case .highToLow:
        sortedProducts = products.sorted(by: { first, second in
            let firstFinalPrice = Double(first.finalPrice?.dropFirst(4).replacingOccurrences(of: ",", with: "") ?? "0.0") ?? 0.0
            let secondFinalPrice = Double(second.finalPrice?.dropFirst(4).replacingOccurrences(of: ",", with: "") ?? "0.0") ?? 0.0
            return firstFinalPrice > secondFinalPrice
        })
    case .lowToHigh:
        sortedProducts = products.sorted(by: { first, second in
            let firstFinalPrice = Double(first.finalPrice?.dropFirst(4).replacingOccurrences(of: ",", with: "") ?? "0.0") ?? 0.0
            let secondFinalPrice = Double(second.finalPrice?.dropFirst(4).replacingOccurrences(of: ",", with: "") ?? "0.0") ?? 0.0
            return firstFinalPrice < secondFinalPrice
        })
    }
}
}
