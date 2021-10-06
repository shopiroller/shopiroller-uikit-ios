//
//  CategoriesCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit
import Kingfisher



class CategoriesCell: UICollectionViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAll: UIImageView!
    @IBOutlet private weak var seeAllContainer: UIView!
    
    var viewModel: [SRCategoryResponseModel]?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(cellClass: CategoriesCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func configureCell(model: [SRCategoryResponseModel]?){
        self.viewModel = model
    }

    
}

extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.configureCell(model: self.viewModel?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.window?.rootViewController?.present(ProductDetailViewController(viewModel: ProductDetailViewModel()), animated: true, completion: nil)

    }
    
    
}

extension CategoriesCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height  = view.frame.height/2
//        return CGSize(width: view.frame.width, height: height)
        return CGSize(width: 60, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
//        descriptionLabel.text = bannerViewModel.description
    }
    
}    
