//
//  ShowCaseCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit

class ShowCaseCell: UICollectionViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(cellClass: ShowCaseCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func configureCell(model: String?){
        self.viewModel = model
        collectionView.reloadData()
    }
    
}

extension ShowCaseCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCaseCollectionViewCell.reuseIdentifier, for: indexPath) as! ShowCaseCollectionViewCell
        cell.configureCell(model: self.viewModel)
        return cell
        
    }
    
    
}

extension ShowCaseCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 70)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
        //        descriptionLabel.text = bannerViewModel.description
    }
    
    
}
