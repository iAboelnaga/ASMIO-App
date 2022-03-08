//
//  ProductViewModel.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import Foundation
import PromiseKit

class ProductViewModel: BaseViewModel {
    private var productId: Int
    private(set) var product: Product?
    private(set) var relatedProducts = [Product]()
    var productFetchingSuccess: (() -> Void)?
    
    init(productId: Int) {
        self.productId = productId
    }
    
    func fetchProduct() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        startRequest(request: CategoriesApi.productDetails(productId: productId), mappingClass: ResponseModel<Product>.self) { [weak self] response in
            self?.product = response?.data
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        startRequest(request: CategoriesApi.relatedProducts(productId: productId), mappingClass: ResponseModel<[Product]>.self) { [weak self] response in
            self?.relatedProducts = response?.data?.filter { $0.id != self?.productId } ?? []
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.productFetchingSuccess?()
        }
    }
    
    func selectProduct(at indexPath: IndexPath) {
        if let productId = relatedProducts[indexPath.row].id {
            self.productId = productId
            self.fetchProduct()
        }
    }
}
