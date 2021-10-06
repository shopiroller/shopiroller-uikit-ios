//
//  SRMainPageViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 21.09.2021.
//

import UIKit
import Kingfisher

extension SRMainPageViewController : NibLoadable { }


private struct Constants {
    
    //TODO
    
}

public class SRMainPageViewController: BaseViewController {
    
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var emptyViewContainer: UIView!
    @IBOutlet private weak var collectionViewContainer: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var isSearchEmpty: Bool = false
    
    
    private let viewModel : SRMainPageViewModel

    
    public init(viewModel: SRMainPageViewModel = SRMainPageViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: SRMainPageViewController.nibName, bundle: Bundle(for: SRMainPageViewController.self))
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = SRMainPageViewModel()
        super.init(coder: aDecoder)
    }
    
    public override func setup() {
        super.setup()
        
        collectionView.register(cellClass: SliderTableViewCell.self)
        collectionView.register(cellClass: CategoriesCell.self)
        collectionView.register(cellClass: ItemCollectionViewCell.self)
        collectionView.register(cellClass: ShowCaseCell.self)
        collectionView.register(ProductsTitleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProductsTitleView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
      
        
        //        do {
        //            try UIFont.register(path:"", fileNameString: "Poppins-Bold", type: ".ttf")
        //            try UIFont.register(path:"", fileNameString: "Poppins-Medium", type: ".ttf")
        //            try UIFont.register(path:"", fileNameString: "Poppins-Regular", type: ".ttf")
        //            try UIFont.register(path:"", fileNameString: "Poppins-SemiBold", type: ".ttf")
        //        } catch let error {
        //            print(error.localizedDescription)
        //        }
        //
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getSliders()
        
        getCategories()
        
        getShowCase()
        
        getProducts()
        
        configureEmptyView()
        
    }
    
    
    private func getSliders() {
        viewModel.getSliders(success: { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getProducts() {
        viewModel.getProducts(succes: {
            [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getCategories() {
        viewModel.getCategories(succes: {
            [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getShowCase() {
        viewModel.getShowCase(succes: {
            [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    
    private func configureEmptyView() {
        if isSearchEmpty {
            collectionViewContainer.isHidden = true
            emptyViewContainer.isHidden = false
            let emptyViewModel = EmptyViewModel(image: UIImage(named: "successOrder", in: Bundle(identifier: "com.shopiroller.shopiroller"), with: nil), title: "Empty Search", description: "Empty Search", buttonTitle:  "HEH", buttonColor: .iceBlue)
            emptyView.setupEmptyView(viewModel: emptyViewModel)
        }else{
            collectionViewContainer.isHidden = false
            emptyViewContainer.isHidden = true
        }
        
    }
    
}

extension SRMainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        return UICollectionViewCell()
    }
}


extension SRMainPageViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.getHeight(type: CellType.slider)))
        case 1:
            return CGSize(width: collectionView.frame.width, height: CGFloat(viewModel.getHeight(type: CellType.categories)))
        case 2:
            return CGSize(width: (collectionView.frame.width), height: ((collectionView.frame.height / 2) - 3 ) * 135 / 182 )
        case 3:
            return CGSize(width: (collectionView.frame.width / 2) - 10, height: ((collectionView.frame.width / 2) - 10 ) * 204 / 155)
        default:
            break
        }
        return CGSize(width: 200, height: 200)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
        //        descriptionLabel.text = bannerViewModel.description
        if indexPath.row == viewModel.productItemCount() - 1 {
            getProducts()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProductsTitleView.identifier, for: indexPath) as! ProductsTitleView
        header.isHidden = false
        return header
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSize(width: 100, height: 25)
        }else{
            return CGSize(width: view.frame.width, height: 0)
        }
    }
    
}
