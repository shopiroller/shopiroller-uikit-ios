//
//  ShowCaseCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit
import Kingfisher

class ShowCaseCell: UICollectionViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var seeAllContainer: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var viewModel: SRShowcaseResponseModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(cellClass: ItemCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let showAllTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.seeAllProducts(_:)))
        seeAllContainer.addGestureRecognizer(showAllTapGesture)
    }
    
    
    func configureCell(viewModel: SRShowcaseResponseModel?){
        self.viewModel = viewModel
        collectionView.reloadData()
        
        titleLabel.text = viewModel?.showcase?.name
        
    
    }
    
    
    @objc func seeAllProducts(_ sender: UITapGestureRecognizer? = nil) {
        //TODO Show All Products
    }
    
}

extension ShowCaseCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products?.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel?.showcase?.isPublished == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.configureCell(viewModel: ProductViewModel(productDetailModel: viewModel?.products?[indexPath.row]))
            return cell
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    
    
}

extension ShowCaseCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 173)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
        //        descriptionLabel.text = bannerViewModel.description
    }
    
    
}
