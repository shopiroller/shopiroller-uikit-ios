//
//  ProductListViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 25.10.2021.
//

import UIKit

class ProductListViewController: BaseViewController<ProductListViewModel> {
    
    private struct Constants {
        static var filterTitle: String { return "filter-title-text".localized }
        static var sortByTitle: String { return "sort-title-text".localized }
    }
    
    @IBOutlet private weak var sortyByTitleLabel: UILabel!
    @IBOutlet private weak var sortByImage: UIImageView!
    @IBOutlet private weak var filterTitleLabel: UILabel!
    @IBOutlet private weak var filterImage: UIImageView!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var filterProductsContainer: UIView!
    @IBOutlet private weak var emptyViewContainer: UIView!
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var collectionViewContainer: UIView!
    
    
    init(viewModel: ProductListViewModel){
        super.init(viewModel: viewModel, nibName: ProductListViewController.nibName, bundle: Bundle(for: ProductListViewController.self))
    }
    
    public override func setup() {
        super.setup()
        getCount()
        filterProductsContainer.layer.cornerRadius = 10
        filterProductsContainer.backgroundColor = .buttonLight
        filterProductsContainer.layer.masksToBounds = true
        filterProductsContainer.clipsToBounds = true
        
        lineView.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.2)
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(cellClass: ItemCollectionViewCell.self)
        
        filterTitleLabel.text = Constants.filterTitle
        filterImage.image = .filterIcon
    
        sortyByTitleLabel.text = Constants.sortByTitle
        sortByImage.image = .sortIcon
    
        getProducts(pagination: true)
        
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let cartButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon, .goToCard , true))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon , .searchProduct))
        let moreButton = UIBarButtonItem(customView: createNavigationItem(.moreIcon , .openOptions))
        updateNavigationBar(rightBarButtonItems:  [moreButton,searchButton,cartButton],isBackButtonActive: true)
        

    }
    
    private func configureEmptyView() {
        if viewModel.getProductCount() == 0 {
            filterProductsContainer.isHidden = true
            collectionViewContainer.isHidden = true
            emptyViewContainer.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
        }else{
            filterProductsContainer.isHidden = false
            collectionViewContainer.isHidden = false
            emptyViewContainer.isHidden = true
        }
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(succes: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getProducts(pagination: Bool) {
        viewModel.getProducts(pagination: pagination,succes: {
            [weak self] in
            guard let self = self else { return }
            self.productsCollectionView.reloadData()
            DispatchQueue.main.async {
                self.configureEmptyView()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = viewModel.getProductModel()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.configureCell(viewModel: ProductViewModel(productListModel: cellModel?[indexPath.row]))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: ((collectionView.frame.width / 2) - 10 ) * 254 / 155)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.getProductCount() - 2){
            getProducts(pagination: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailViewController(viewModel: ProductDetailViewModel(productId: viewModel.getProductId(position: indexPath.row)))
        prompt(vc, animated: true, completion: nil)
    }
    
}

