//
//  ProductDetailsViewController.swift
//  ASMIO App
//
//  Created by Ahmed Aboelnaga on 06/03/2022.
//

import Cosmos

class ProductDetailsViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imagePageControl: DashPageControl!
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var upperCosmosView: CosmosView!
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UnderlinedLabel!
    @IBOutlet weak var overViewArrowImage: UIImageView!
    @IBOutlet weak var overViewView: UIView!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var specificationsArrowImage: UIImageView!
    @IBOutlet weak var specificationsView: UIView!
    @IBOutlet weak var specificationsTableView: SelfSizedTableView!
    @IBOutlet weak var offersArrowImage: UIImageView!
    @IBOutlet weak var offerDetailsView: UIView!
    @IBOutlet weak var productOfferLabel: UILabel!
    @IBOutlet weak var ratingArrowImage: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var ratingsTableView: UITableView!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var viewAllReviewsButton: UIButton!
    @IBOutlet weak var relatedProductsCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let viewModel: ProductViewModel
    var isFavorite = false

    init(productId: Int) {
        self.viewModel = ProductViewModel(productId: productId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupViewModel()
        viewModel.fetchProduct()
        
    }
    func setupViews() {
        
        ratingsTableView.delegate = self
        ratingsTableView.dataSource = self
        ratingsTableView.registerCellNib(cellClass: ReviewsTableViewCell.self)
        specificationsTableView.delegate = self
        specificationsTableView.dataSource = self
        specificationsTableView.registerCellNib(cellClass: SpecificationsTableViewCell.self)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.registerCellNib(cellClass: ImageCollectionViewCell.self)
        relatedProductsCollectionView.delegate = self
        relatedProductsCollectionView.dataSource = self
        relatedProductsCollectionView.registerCellNib(cellClass: ProductCollectionViewCell.self)
        viewAllReviewsButton.semanticContentAttribute = .forceRightToLeft
        
    }
    func setupViewModel() {
        setupViewModel(viewModel: viewModel)
        viewModel.productFetchingSuccess = { [weak self] in
            self?.scrollView.scrollTo(direction: .top, animated: true)
            self?.setData()
        }
    }
    
    func setData() {
        guard let product = viewModel.product else {
            showAlert(message: "Something Went Wrong, Please Try Again Later")
            return
        }
        //check if product has a discount or not
        if let discount = product.discount,
           discount != "" {
            discountPercentageLabel.text = discount
            originalPriceLabel.attributedText = product.originPrice?.strikeThrough()
        }else {
            discountPercentageLabel.isHidden = true
            originalPriceLabel.isHidden = true
        }
        
        finalPriceLabel.text = product.finalPrice?.dropFirst(4).description
        vatLabel.isHidden = !(product.showVat ?? true)
        let brand = product.specifications?.first { $0.key?.lowercased().contains("brand") ?? false }
        brandLabel.text = brand?.value
        productNameLabel.text = product.name
        sellerNameLabel.text = product.seller
        overViewLabel.text = product.shortDescription?.htmlToString
        productOfferLabel.text = product.productDescription?.htmlToString
        let totalRating = product.reviews?.averageRating ?? 0.0
        upperCosmosView.rating = totalRating
        overallRating.text = totalRating.description
        ratingCosmosView.rating = totalRating
        totalReviews.text = (product.reviews?.total ?? 0).description + " reviews"
        imagePageControl.numberOfPages = product.images?.count ?? 0
        imagesCollectionView.reloadData()
        ratingsTableView.reloadData()
        specificationsTableView.reloadData()
        relatedProductsCollectionView.reloadData()
    }

    @IBAction func overViewTapped(_ sender: Any) {
        overViewView.isHidden.toggle()
        overViewArrowImage.animateRotation()
    }
    
    @IBAction func specificationsTapped(_ sender: Any) {
        specificationsView.isHidden.toggle()
        specificationsArrowImage.animateRotation()
    }
    
    @IBAction func offerDetailsTapped(_ sender: Any) {
        offerDetailsView.isHidden.toggle()
        offersArrowImage.animateRotation()
    }
    
    @IBAction func reviewsTapped(_ sender: Any) {
        ratingView.isHidden.toggle()
        ratingArrowImage.animateRotation()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        pop()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        isFavorite.toggle()
        if isFavorite {
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }else {
            favoriteButton.setImage(#imageLiteral(resourceName: "not-favorite"), for: .normal)
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let items = ["Check \(viewModel.product?.name ?? "this product") with only \(viewModel.product?.finalPrice ?? "0.0 EGP")"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(ac)
        }
    }
}

extension ProductDetailsViewController: UITableViewDelegate {
    
}

extension ProductDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case specificationsTableView:
            return viewModel.product?.specifications?.count ?? 0
        case ratingsTableView:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case specificationsTableView:
            let cell = specificationsTableView.dequeue() as SpecificationsTableViewCell
            let specification = viewModel.product?.specifications?[indexPath.row]
            cell.configure(with: specification, index: indexPath.row)
            return cell
        case ratingsTableView:
            let cell = ratingsTableView.dequeue() as ReviewsTableViewCell
            let percentages = viewModel.product?.reviews?.percentage
            switch indexPath.row {
            case 0:
                cell.configure(with: percentages?.fiveStar, type: .excellent)
            case 1:
                cell.configure(with: percentages?.fourStar, type: .good)
            case 2:
                cell.configure(with: percentages?.threeStar, type: .average)
            case 3:
                cell.configure(with: percentages?.twoStar, type: .belowAverage)
            case 4:
                cell.configure(with: percentages?.oneStar, type: .poor)
            default:
                break
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == relatedProductsCollectionView {
            viewModel.selectProduct(at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case imagesCollectionView:
            return CGSize(width: imagesCollectionView.frame.width,
                          height: imagesCollectionView.frame.height)
        case relatedProductsCollectionView:
            return CGSize(width: 150,
                          height: 223)
        default:
            return .zero
        }
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imagesCollectionView:
            return viewModel.product?.images?.count ?? 0
        case relatedProductsCollectionView:
            return viewModel.relatedProducts.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imagesCollectionView:
            let cell = collectionView.dequeue(indexPath: indexPath) as ImageCollectionViewCell
            cell.configure(with: viewModel.product?.images?[indexPath.row])
            return cell
        case relatedProductsCollectionView:
            let cell = collectionView.dequeue(indexPath: indexPath) as ProductCollectionViewCell
            cell.configure(with: viewModel.relatedProducts[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == imagesCollectionView {
            imagePageControl.currentPage = indexPath.row
        }
    }
}
