//
//  CategoriesCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
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
        collectionView.reloadData()
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
    
    
}

extension CategoriesCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height  = view.frame.height/2
//        return CGSize(width: view.frame.width, height: height)
        return CGSize(width: 60, height: 70)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
//        descriptionLabel.text = bannerViewModel.description
    }
    
}
    
