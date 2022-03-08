//
//  CategoriesViewController.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import UIKit

class CategoriesViewController: BaseViewController {

    @IBOutlet weak var categoryProductsCollectionView: UICollectionView! {
        didSet {
            categoryProductsCollectionView.delegate = self
            categoryProductsCollectionView.dataSource = self
            categoryProductsCollectionView.prefetchDataSource = self
            categoryProductsCollectionView.registerCellNib(cellClass: ProductCollectionViewCell.self)
        }
    }
    
    private let viewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        viewModel.fetchProducts()
    }
    
    func setupViewModel() {
        setupViewModel(viewModel: viewModel)
        viewModel.reloadData = { [weak self] in
            self?.categoryProductsCollectionView.reloadData()
        }
    }
    
    @IBAction func searchViewTapGestureRecognized(_ sender: Any) {
        //TODO
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //TODO
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        let sortViewController = SortViewController()
        sortViewController.delegate = self
        sortViewController.selectedOption = viewModel.sortingOption
        sortViewController.modalTransitionStyle = .coverVertical
        sortViewController.modalPresentationStyle = .overCurrentContext
        present(sortViewController)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        //TODO
    }
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        push(ProductDetailsViewController(productId: viewModel.sortedProducts[indexPath.row].id ?? 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        return CGSize(width: collectionWidth/2 - 13, height: 225)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.sortedProducts.count
        if count == 0 {
            collectionView.setEmptyView(title: "", message: "No Products Found")
        }else {
            collectionView.restore()
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as ProductCollectionViewCell
        cell.configure(with: viewModel.sortedProducts[indexPath.row])
        return cell
    }
}


extension CategoriesViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.last?.row == viewModel.sortedProducts.count - 1{
            viewModel.fetchProducts()
        }
    }
}

extension CategoriesViewController: SortDelegate {
    func didSelect(sortOption: SortOptions) {
        dismiss()
        viewModel.sortingOption = sortOption
    }
    
}
