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
    
    @IBOutlet private weak var contentStackView: UIStackView!
    @IBOutlet private weak var sortFilterContainerView: UIView!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var sortButton: UIButton!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var emptyView: EmptyView!
    
    private let badgeView = SRBadgeButton()
    
    private var filterRedDotView = UIView()
        
    init(viewModel: ProductListViewModel){
        super.init(viewModel.getPageTitle(),viewModel: viewModel, nibName: ProductListViewController.nibName, bundle: Bundle(for: ProductListViewController.self))
        title = viewModel.getPageTitle()
    }
    
    public override func setup() {
        super.setup()
        getCount()
        sortFilterContainerView.layer.cornerRadius = 10
        sortFilterContainerView.backgroundColor = .buttonLight
        sortFilterContainerView.layer.masksToBounds = true
        sortFilterContainerView.clipsToBounds = true
        
        lineView.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.2)
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(cellClass: ItemCollectionViewCell.self)
        
        sortButton.setTitle("sort-title-text".localized)
        sortButton.setTitleColor(.textPrimary)
        sortButton.tintColor = .textPrimary
        filterButton.setTitle("filter-title-text".localized)
        filterButton.setTitleColor(.textPrimary)
        filterButton.tintColor = .textPrimary
        
        filterRedDotView = UIView(frame: CGRect(x: filterButton.imageView!.frame.width + 15, y: 0, width: 10, height: 10))
        filterRedDotView.backgroundColor = .red
        filterRedDotView.layer.cornerRadius = filterRedDotView.frame.height / 2
        filterButton.imageView!.addSubview(filterRedDotView)
        
    
        getProducts(pagination: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCount()
        filterRedDotView.isHidden = !viewModel.hasFilter()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadgeCount), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateShoppighCartObserve), object: nil)
    }
    
    @objc func updateBadgeCount() {
        badgeView.badge = SRAppContext.shoppingCartCount
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let cartButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon, .goToCard))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon , .searchProduct))
        updateNavigationBar(rightBarButtonItems:  [searchButton, cartButton],isBackButtonActive: true)
        cartButton.customView?.addSubview(badgeView)
    }
    
    private func configureEmptyView() {
        if viewModel.getProductCount() == 0 {
            sortFilterContainerView.isHidden = !viewModel.hasFilter()
            productsCollectionView.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
        }else{
            sortFilterContainerView.isHidden = false
            productsCollectionView.isHidden = false
            emptyView.isHidden = true
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
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        let sortPopUpVC = ListPopUpViewController(viewModel: ListPopUpViewModel(listType: .sortList, selectedSortIndex: viewModel.getSelectedSortIndex()))
        sortPopUpVC.sortDelegate = self
        popUp(sortPopUpVC, completion: nil)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        prompt(FilterViewController(viewModel: viewModel.getFilterViewModel(), delegate: self), animated: true, completion: nil)
    }
    
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = viewModel.getProductModelList()
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

extension ProductListViewController: FilterViewControllerDelegate {
    func confirmedFilter(model: FilterModel) {
        viewModel.setFilterModel(model)
        getProducts(pagination: false)
    }
}

extension ProductListViewController: ListPopUpSortDelegate {
    func getSelectedSortIndex(index: Int) {
        viewModel.setSelectedSortIndex(index: index)
        getProducts(pagination: false)
    }
}

