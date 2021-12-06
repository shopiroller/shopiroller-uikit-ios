//
//  SRMainPageViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 21.09.2021.
//

import UIKit
import Kingfisher

public class SRMainPageViewController: BaseViewController<SRMainPageViewModel> {
    
    private struct Constants {
        
        static var productsTitleIdentifier: String { return "products-identifier".localized }
    }

    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var emptyViewContainer: UIView!
    @IBOutlet private weak var collectionViewContainer: UIView!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var shimmerCollectionView: UICollectionView!
    
    private var refreshControl = UIRefreshControl()
    
    private let badgeView = SRBadgeButton()

    private var group : DispatchGroup? = nil

    public init(viewModel: SRMainPageViewModel) {
        super.init("explore-page-title".localized, viewModel: viewModel, nibName: SRMainPageViewController.nibName, bundle: Bundle(for: SRMainPageViewController.self))
    }
    
    public override func setup() {
        super.setup()
        view.backgroundColor = .white

        shimmerCollectionView.delegate = self
        shimmerCollectionView.dataSource = self
        shimmerCollectionView.register(cellClass: ItemCollectionViewCell.self)
        shimmerCollectionView.reloadData()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(cellClass: SliderTableViewCell.self)
        mainCollectionView.register(cellClass: CategoriesCell.self)
        mainCollectionView.register(cellClass: ItemCollectionViewCell.self)
        mainCollectionView.register(cellClass: ShowCaseCell.self)
        mainCollectionView.register(ProductsTitleView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: Constants.productsTitleIdentifier)
       
        getSliders(showProgress: true)
        getCategories(showProgress: true)
        getShowCase(showProgress: true)
        getProducts(showProgress: true)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCount()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadgeCount), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateShoppighCartObserve), object: nil)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let cartButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon , .goToCard))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon, .searchProduct))
        let optionsButton = UIBarButtonItem(customView: createNavigationItem(.moreIcon, .openOptions))
        updateNavigationBar(rightBarButtonItems:  [optionsButton,searchButton,cartButton])
        cartButton.customView?.addSubview(badgeView)
    }
    
    @objc func updateBadgeCount() {
        badgeView.badge = SRAppContext.shoppingCartCount
    }
    
    func configureRefreshControl () {
        mainCollectionView.refreshControl = UIRefreshControl()
        mainCollectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh(_ sender: Any) {
        group = DispatchGroup()
        group?.enter()
        group?.enter()
        group?.enter()
        group?.enter()
                
        self.getSliders(showProgress: false)
        self.getCategories(showProgress: false)
        self.getShowCase(showProgress: false)
        self.getProducts(showProgress: false)
        
        group?.notify(queue: .main, execute: {
            self.group = nil
            if self.mainCollectionView.isDragging == false {
                self.mainCollectionView.refreshControl?.endRefreshing()
                self.mainCollectionView.reloadData()
                self.configureEmptyView()
            }
        })
    }
    
    private func getSliders(showProgress: Bool) {
        viewModel.getSliders(showProgress: showProgress,success: { [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            } else {
                self.mainCollectionView.reloadData()
            }
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getProducts(showProgress: Bool) {
        viewModel.getProducts(showProgress: showProgress, succes: {
            [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            } else {
                self.shimmerCollectionView.isHidden = false
                self.configureEmptyView()
                self.mainCollectionView.reloadData()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
            self.shimmerCollectionView.isHidden = true
        }
    }
    
    private func getCategories(showProgress: Bool) {
        viewModel.getCategories(showProgress: showProgress,succes: {
            [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            }else {
                self.mainCollectionView.reloadData()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func getShowCase(showProgress: Bool) {
        viewModel.getShowCase(showProgress: showProgress,succes: {
            [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            }else {
                self.mainCollectionView.reloadData()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func configureEmptyView() {
        if viewModel.productItemCount() == 0 {
            shimmerCollectionView.isHidden = true
            emptyView.setup(model: viewModel.getEmptyModel())
            collectionViewContainer.isHidden = true
            emptyViewContainer.isHidden = false
            scrollView.isScrollEnabled = false
        }else{
            collectionViewContainer.isHidden = false
            emptyViewContainer.isHidden = true
            configureRefreshControl()
        }
    }
    
}

extension SRMainPageViewController : ShowCaseProductIdProtocol {
    func getProductId(productId: String) {
        let vc = ProductDetailViewController(viewModel: ProductDetailViewModel(productId: productId))
        self.prompt(vc, animated: true)
    }
}

extension SRMainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainCollectionView {
            switch section {
            case 0:
                return viewModel.sliderItemCount()
            case 1:
                return viewModel.categoryItemCount()
            case 2:
                return viewModel.showcaseItemCount()
            case 3:
                return viewModel.productItemCount()
            default:
                break
            }
            return 1
        }else {
            return 15
        }
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(succes: {
            [weak self] in
            guard let self = self else { return }
            
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView{
        case mainCollectionView:
            return 4
        case shimmerCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainCollectionView:
            switch indexPath.section {
            case 0:
                if viewModel.sliderItemCount() == 0 {
                    mainCollectionView.deleteSections(IndexSet.init(integer: 0))
                } else {
                    let cellModel = viewModel.getTableSliderVieWModel(position: indexPath.row)
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderTableViewCell.reuseIdentifier, for: indexPath) as! SliderTableViewCell
                    cell.setup(viewModel: cellModel)
                    cell.delegate = self
                    return cell
                }
                mainCollectionView.reloadData()
            case 1:
                if viewModel.categoryItemCount() == 0 {
                    mainCollectionView.deleteSections(IndexSet.init(integer: 1))
                } else {
                    let cellModel = viewModel.getCategoriesViewModel()
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseIdentifier, for: indexPath) as! CategoriesCell
                    cell.configureCell(model: cellModel)
                    cell.delegate = self
                    return cell
                }
                mainCollectionView.reloadData()
            case 2:
                if viewModel.showcaseItemCount() == 0 {
                    mainCollectionView.deleteSections(IndexSet.init(integer: 2))
                } else {
                    let cellModel = viewModel.getShowCaseViewModel(position: indexPath.row)
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCaseCell.reuseIdentifier, for: indexPath) as! ShowCaseCell
                    cell.delegate = self
                    cell.configureCell(viewModel: cellModel)
                    return cell
                }
                mainCollectionView.reloadData()
            case 3:
                if viewModel.productItemCount() == 0 {
                    mainCollectionView.deleteSections(IndexSet.init(integer: 3))
                } else {
                    let cellModel = viewModel.getTableProductVieWModel()
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                    cell.configureCell(viewModel: ProductViewModel(productListModel: cellModel?[indexPath.row]))
                    return cell
                }
                mainCollectionView.reloadData()
            default:
                break
            }
        case shimmerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.startShimmer()
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 3:
            let vc = ProductDetailViewController(viewModel: ProductDetailViewModel(productId: viewModel.getProductId(position: indexPath.row) ?? ""))
            self.prompt(vc, animated: true)
        default:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = mainCollectionView!.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.productsTitleIdentifier, for: indexPath) as! ProductsTitleView
        return reusableView
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 3:
            return CGSize(width: collectionView.frame.width, height: 40)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
}

extension SRMainPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case mainCollectionView:
            switch indexPath.section {
            case 0:
                return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.getHeight(type: CellType.slider)))
            case 1:
                return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.getHeight(type: CellType.categories)))
            case 2:
                return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height / 2)  * 135 / 170 )
            case 3:
                return CGSize(width: ((collectionView.frame.width / 2) - 5), height: ((collectionView.frame.width / 2) - 10 ) * 204 / 155)
            default:
                break
            }
        case shimmerCollectionView:
            return CGSize(width: (collectionView.frame.width / 2) - 10, height: ((collectionView.frame.width / 2) - 10 ) * 204 / 155)
        default:
            break
        }
       return CGSize(width: 200, height: 200)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.productItemCount() - 2{
            getProducts(showProgress: true)
        }
    }
    
}

extension SRMainPageViewController : CategoriesCellDelegate {
   
    func getSubCategories(position: Int) {
        
        if viewModel.hasSubCategory(position: position){
            let vc = CategoriesListViewController(viewModel: CategoriesListViewModel(categoryList: viewModel.getSubCategories(position: position), isSubCategory: true,selectedRowName: viewModel.getCategoryName(position: position),categoryId: viewModel.getCategoryId(position: position)))
            self.prompt(vc, animated: true, completion: nil)
        }else {
            let vc = ProductListViewController(viewModel: ProductListViewModel(categoryId: viewModel.getCategoryId(position: position),categoryTitle: viewModel.getCategoryName(position: position)))
            prompt(vc, animated: true, completion: nil)
        }
        
    }
    func getCategories(position: Int) {
        let vc = CategoriesListViewController(viewModel: CategoriesListViewModel(categoryList: viewModel.getCategoriesViewModel(), isSubCategory: false))
        self.prompt(vc, animated: true, completion: nil)
    }
}

extension SRMainPageViewController: SliderClickDelegate {
    
    func openProductDetail(id: String?) {
        let vc = ProductDetailViewController(viewModel: ProductDetailViewModel(productId: id ?? ""))
        self.prompt(vc, animated: false, completion: nil)
    }
    
    func openProductList(categoryId: String?) {
        let vc = ProductListViewController(viewModel: ProductListViewModel(categoryId: categoryId))
        self.prompt(vc, animated: false, completion: nil)
    }
    
    func openWebView(link: String?) {
        let vc = WebViewController(viewModel: WebViewViewModel(webViewUrl: link))
        self.prompt(vc, animated: false, completion: nil)
    }
    
    
    
}
