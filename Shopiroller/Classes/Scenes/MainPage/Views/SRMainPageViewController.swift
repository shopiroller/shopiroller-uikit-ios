//
//  SRMainPageViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 21.09.2021.
//

import UIKit
import Kingfisher

open class SRMainPageViewController: BaseViewController<SRMainPageViewModel> {
    
    private struct Constants {
        static var productsTitleIdentifier: String { return "products-identifier".localized }
    }
    
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var emptyViewContainer: UIView!
    @IBOutlet private weak var collectionViewContainer: UIView!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var shimmerCollectionView: UICollectionView!
    @IBOutlet private weak var floatingButton: UIButton!
    
    private var refreshControl = UIRefreshControl()
    
    private let badgeView = SRBadgeButton()
    
    private var group : DispatchGroup? = nil
    
    public init(viewModel: SRMainPageViewModel) {
        super.init(nil, viewModel: viewModel, nibName: SRMainPageViewController.nibName, bundle: Bundle(for: SRMainPageViewController.self))
    }
    
    open override func setup() {
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
        getProducts(showProgress: true, isPagination: false)
        getClient()
        
        configureRefreshControl()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCount()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadgeCount), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateShoppighCartObserve), object: nil)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        var rightBarButtonItems : [UIBarButtonItem] = []
        let cartButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon , .goToCard))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon, .searchProduct))
        rightBarButtonItems.append(cartButton)
        rightBarButtonItems.append(searchButton)
        
        if (SRAppContext.developmentMode) {
            let optionsButton = UIBarButtonItem(customView: createNavigationItem(UIImage(systemName: "figure.wave"), .openOptions))
            rightBarButtonItems.append(optionsButton)
        }
        
        updateNavigationBar(rightBarButtonItems:  rightBarButtonItems, isBackButtonActive: false)
        cartButton.customView?.addSubview(badgeView)
    }
    
    @objc func updateBadgeCount() {
        badgeView.badgeCount = SRAppContext.shoppingCartCount
    }
    
    func configureRefreshControl () {
        mainCollectionView.refreshControl = UIRefreshControl()
        if !(self.navigationController?.isNavigationBarHidden ?? false) {
            mainCollectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        }
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
        self.getProducts(showProgress: false, isPagination: false)
        
        group?.notify(queue: .main, execute: {
            
            self.viewModel.reloadSections()
            
            self.group = nil
            self.mainCollectionView.refreshControl?.endRefreshing()
            self.mainCollectionView.reloadData()
            self.configureEmptyView()
        })
    }
    
    private func getClient() {
        viewModel.getClient(success: { [weak self] in
            guard let self = self else { return }
            self.floatingButton.isHidden = !self.viewModel.whatsAppMobileIsActive()
        })
    }
    
    private func getSliders(showProgress: Bool) {
        viewModel.getSliders(showProgress: showProgress,success: { [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            } else {
                self.viewModel.reloadSections()
                self.view.layoutIfNeeded()
                self.mainCollectionView.reloadData()
            }
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            }
        }
    }
    
    private func getProducts(showProgress: Bool, isPagination: Bool = false) {
        viewModel.getProducts(showProgress: showProgress, isPagination: isPagination, success: {
            [weak self] in
            guard let self = self else { return }
            if self.group != nil && !isPagination {
                self.group?.leave()
            } else {
                self.viewModel.reloadSections()
                self.shimmerCollectionView.isHidden = false
                self.configureEmptyView()
                self.mainCollectionView.reloadData()
                self.view.layoutIfNeeded()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            }
            self.showAlertError(viewModel: errorViewModel)
            self.shimmerCollectionView.isHidden = true
        }
    }
    
    private func getCategories(showProgress: Bool) {
        viewModel.getCategories(showProgress: showProgress,success: {
            [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            } else {
                self.viewModel.reloadSections()
                self.view.layoutIfNeeded()
                self.mainCollectionView.reloadData()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func getShowCase(showProgress: Bool) {
        viewModel.getShowCase(showProgress: showProgress,success: {
            [weak self] in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            } else {
                self.viewModel.reloadSections()
                self.view.layoutIfNeeded()
                self.mainCollectionView.reloadData()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            if self.group != nil {
                self.group?.leave()
            }
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
        } else {
            collectionViewContainer.isHidden = false
            emptyViewContainer.isHidden = true
        }
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > 0) {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                scrollView.isScrollEnabled = true
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }, completion: nil)
        }
    }
    
    @IBAction func floatingButtonTapped(_ sender: Any) {
        if let number = viewModel.getWhatsAppNumber(), let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(number)"), UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
    }
}

extension SRMainPageViewController : ShowCaseCellDelegate {
    func getShowCaseInfo(showcaseId: String?, title: String?) {
        let productListVC = SRProductListViewController(viewModel: SRProductListViewModel(pageTitle: title,showcaseId: showcaseId))
        post(productListVC, animated: true)
    }
    
    func getProductId(productId: String) {
        let productDetailVC = SRProductDetailViewController(viewModel: SRProductDetailViewModel(productId: productId))
        post(productDetailVC, animated: true)
    }
}

extension SRMainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainCollectionView {
            switch viewModel.getSectionAt(position: section) {
            case .slider:
                return viewModel.sliderItemCount()
            case .categories:
                return viewModel.categoryItemCount()
            case .showcase:
                return viewModel.showcaseItemCount()
            case .products:
                return viewModel.productItemCount()
            default:
                break
            }
            return 1
        }else {
            return 15
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView{
        case mainCollectionView:
            return viewModel.getSectionCount()
        case shimmerCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainCollectionView:
            switch viewModel.getSectionAt(position: indexPath.section) {
            case .slider:
                let cellModel = viewModel.getTableSliderVieWModel(position: indexPath.row)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderTableViewCell.reuseIdentifier, for: indexPath) as! SliderTableViewCell
                cell.setup(viewModel: cellModel)
                cell.delegate = self
                return cell
            case .categories:
                let cellModel = viewModel.getCategoriesViewModel()
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseIdentifier, for: indexPath) as! CategoriesCell
                cell.configureCell(model: cellModel, categoryDisplayTypeEnum: viewModel.getMobileSettingsEnum())
                cell.delegate = self
                return cell
            case .showcase:
                let cellModel = viewModel.getShowCaseViewModel(position: indexPath.row)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCaseCell.reuseIdentifier, for: indexPath) as! ShowCaseCell
                cell.delegate = self
                cell.configureCell(viewModel: cellModel)
                return cell
            case .products:
                let cellModel = viewModel.getTableProductVieWModel()
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                cell.configureCell(viewModel: ProductViewModel(productDetailModel: cellModel?[indexPath.row]))
                return cell
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
        switch viewModel.getSectionAt(position: indexPath.section) {
        case .products:
            let productDetailVC = SRProductDetailViewController(viewModel: SRProductDetailViewModel(productId: viewModel.getProductId(position: indexPath.row) ?? ""))
            self.post(productDetailVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = mainCollectionView!.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.productsTitleIdentifier, for: indexPath) as! ProductsTitleView
        return reusableView
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch collectionView {
        case mainCollectionView:
            switch viewModel.getSectionAt(position: section) {
            case .products:
                return CGSize(width: collectionView.frame.width, height: 55)
            default:
                return CGSize.zero
            }
        default:
            return CGSize.zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case mainCollectionView:
            switch viewModel.getSectionAt(position: section) {
            case .categories,.products:
                return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            default:
                break
            }
        default:
            break
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension SRMainPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case mainCollectionView:
            switch viewModel.getSectionAt(position: indexPath.section) {
            case .slider:
                return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.getHeight(type: CellType.slider)))
            case .categories:
                return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.getHeight(type: CellType.categories)))
            case .showcase:
                return CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height / 2)  * 125 / 170 )
            case .products:
                return CGSize(width: ((collectionView.frame.width / 2) - 30),  height: ((collectionView.frame.width / 2) - 10 ) * 224 / 145)
            }
        case shimmerCollectionView:
            return CGSize(width: (collectionView.frame.width / 2) - 10, height: ((collectionView.frame.width / 2) - 10 ) * 204 / 155)
        default:
            break
        }
        return CGSize(width: 200, height: 200)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (collectionView == mainCollectionView) {
            switch viewModel.getSectionAt(position: indexPath.section) {
            case .products:
                if indexPath.row == viewModel.productItemCount() - 2 {
                    getProducts(showProgress: true, isPagination: true)
                }
            default:
                break
            }
        }
        
    }
    
}

extension SRMainPageViewController : CategoriesCellDelegate {
    
    func getSubCategories(position: Int) {
        
        if viewModel.hasSubCategory(position: position){
            let categoriesListVC = SRCategoriesListViewController(viewModel: viewModel.getCategoriesListViewModel(position: position))
            post(categoriesListVC, animated: true, completion: nil)
        } else {
            let productListVC = SRProductListViewController(viewModel: viewModel.getProductListViewModel(position: position))
            post(productListVC, animated: true, completion: nil)
        }
        
    }
    func getCategories(position: Int) {
        let categoriesListViewController = SRCategoriesListViewController(viewModel: SRCategoriesListViewModel(categoryList: viewModel.getCategoriesViewModel(), isSubCategory: false,categoryDisplayTypeEnum: viewModel.getMobileSettingsEnum()))
        self.post(categoriesListViewController, animated: true, completion: nil)
    }
}

extension SRMainPageViewController: SliderClickDelegate {
    
    func openProductDetail(id: String?) {
        let productDetailVC = SRProductDetailViewController(viewModel: SRProductDetailViewModel(productId: id ?? ""))
        post(productDetailVC, animated: false, completion: nil)
    }
    
    func openProductList(categoryId: String?) {
        let productListVC = SRProductListViewController(viewModel: SRProductListViewModel(categoryId: categoryId,pageTitle: viewModel.getSliderCategoryName(id: categoryId)))
        post(productListVC, animated: false, completion: nil)
    }
    
    func openWebView(link: String?) {
        let webViewVC = WebViewController(viewModel: WebViewViewModel(webViewUrl: link))
        post(webViewVC, animated: false, completion: nil)
    }
}
