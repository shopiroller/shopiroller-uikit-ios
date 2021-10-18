//
//  SRMainPageViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 21.09.2021.
//

import UIKit
import Kingfisher

private struct Constants {
    
    static var productsTitleIdentifier: String { return "products-identifier".localized }
    
}
public class SRMainPageViewController: BaseViewController<SRMainPageViewModel> {
    
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var emptyViewContainer: UIView!
    @IBOutlet private weak var collectionViewContainer: UIView!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var shimmerCollectionView: UICollectionView!
    
    private var refreshControl = UIRefreshControl()
    
    public init(viewModel: SRMainPageViewModel){
        super.init(viewModel: viewModel, nibName: SRMainPageViewController.nibName, bundle: Bundle(for: SRMainPageViewController.self))
    }
    
    public override func setup() {
        super.setup()
        
        shimmerCollectionView.register(cellClass: ItemCollectionViewCell.self)
        shimmerCollectionView.delegate = self
        shimmerCollectionView.dataSource = self
        shimmerCollectionView.reloadData()
        mainCollectionView.register(cellClass: SliderTableViewCell.self)
        mainCollectionView.register(cellClass: CategoriesCell.self)
        mainCollectionView.register(cellClass: ItemCollectionViewCell.self)
        mainCollectionView.register(cellClass: ShowCaseCell.self)
        mainCollectionView.register(ProductsTitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: Constants.productsTitleIdentifier)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.clipsToBounds = false
        
        getProducts(pagination: false)
    }
    
    func configureRefreshControl () {
        // Add the refresh control to your UIScrollView object.
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(didPullToRefresh),
                                             for: .valueChanged)
    }
    
    @objc func didPullToRefresh(_ sender: Any) {
        getSliders()
        getCategories()
        getShowCase()
        getProducts(pagination: false)
        
        if SRAppContext.isLoading == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.scrollView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func getSliders() {
        viewModel.getSliders(success: { [weak self] in
            guard let self = self else { return }
            self.mainCollectionView.reloadData()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getProducts(pagination: Bool) {
        viewModel.getProducts(pagination: pagination,succes: {
            [weak self] in
            guard let self = self else { return }
            self.mainCollectionView.reloadData()
            self.shimmerCollectionView.isHidden = false
            DispatchQueue.main.async {
                self.configureEmptyView()
            }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getCategories() {
        viewModel.getCategories(succes: {
            [weak self] in
            guard let self = self else { return }
            self.mainCollectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getShowCase() {
        viewModel.getShowCase(succes: {
            [weak self] in
            guard let self = self else { return }
            self.mainCollectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    
    private func configureEmptyView() {
        if viewModel.productItemCount() == 0 {
            collectionViewContainer.isHidden = true
            emptyViewContainer.isHidden = false
            scrollView.isScrollEnabled = false
            emptyView.setupEmptyView(viewModel: viewModel.getEmptyViewModel())
        }else{
            collectionViewContainer.isHidden = false
            emptyViewContainer.isHidden = true
            configureRefreshControl()
            getSliders()
            getCategories()
            getShowCase()
        }
        
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
                let cellModel = viewModel.getTableSliderVieWModel(position: indexPath.row)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderTableViewCell.reuseIdentifier, for: indexPath) as! SliderTableViewCell
                cell.setup(viewModel: cellModel)
                return cell
            case 1:
                let cellModel = viewModel.getCategoriesViewModel()
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseIdentifier, for: indexPath) as! CategoriesCell
                cell.configureCell(model: cellModel)
                return cell
            case 2:
                let cellModel = viewModel.getShowCaseViewModel(position: indexPath.row)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCaseCell.reuseIdentifier, for: indexPath) as! ShowCaseCell
                cell.configureCell(viewModel: cellModel)
                return cell
            case 3:
                let cellModel = viewModel.getTableProductVieWModel()
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                cell.configureCell(viewModel: ProductViewModel(productListModel: cellModel?[indexPath.row]))
                return cell
            default:
                break
            }
        case shimmerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.configureShimmer()
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            break
            //TODO OPEN Product Detail handle showcase
        case 3:
            let vc = MyOrdersViewController(viewModel: MyOrdersViewModel())
            self.prompt(vc, animated: true)
        default:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = mainCollectionView!.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.productsTitleIdentifier, for: indexPath) as! ProductsTitleView
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
                return CGSize(width: (collectionView.frame.width / 2) - 10, height: ((collectionView.frame.width / 2) - 10 ) * 204 / 155)
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
        print(indexPath.row)
        if (indexPath.row == viewModel.productItemCount() - 2){
            getProducts(pagination: true)
        }
    }
    
}
