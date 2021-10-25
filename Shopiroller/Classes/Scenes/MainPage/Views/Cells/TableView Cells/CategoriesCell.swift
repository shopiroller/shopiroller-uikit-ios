//
//  CategoriesCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit
import Kingfisher

protocol CategoriesCellDelegate : AnyObject {
    func getSubCategories(position: Int)
    func getCategories(position: Int)
}


class CategoriesCell: UICollectionViewCell {
    
    private struct Constants {
        
        static var sectiontitle: String { return "categories-section-title".localized  }
        static var seeAllTitle: String { return "section-see-all-title".localized  }
        
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seeAllImage: UIImageView!
    @IBOutlet private weak var seeAllContainer: UIView!
    @IBOutlet private weak var seeAllTitle: UILabel!
    @IBOutlet private weak var sectionTitleLabel: UILabel!
    
    var viewModel: [SRCategoryResponseModel]?
    
    var delegate: CategoriesCellDelegate?
    
    private var cellPosition: Int = 0
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let seeAllTapGesture = UITapGestureRecognizer(target: self, action: #selector(goToCategory))
        seeAllContainer.addGestureRecognizer(seeAllTapGesture)
        seeAllTitle.text = Constants.seeAllTitle
        sectionTitleLabel.text = Constants.sectiontitle
        seeAllImage.image = .rightArrow
        
        collectionView.register(cellClass: CategoriesCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func configureCell(model: [SRCategoryResponseModel]?){
        self.viewModel = model
    }
    
    @objc func goToCategory() {
        self.delegate?.getCategories(position: cellPosition)
    }
    
}

extension CategoriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        self.cellPosition = indexPath.row
        cell.configureCell(model: self.viewModel?[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.getSubCategories(position: indexPath.row)
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
