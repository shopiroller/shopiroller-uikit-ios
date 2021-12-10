//
//  ShowCaseCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit
import Kingfisher

protocol ShowCaseCellDelegate : AnyObject {
    func getProductId(productId: String)
    func getShowCaseInfo(showcaseId : String?,title: String?)
}

public class ShowCaseCell: UICollectionViewCell  {
    
    private struct Constants {
        static var seeAllTitle: String { return "section-see-all-title".localized  }
    }

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var seeAllContainer: UIView!
    @IBOutlet private weak var seeAllImage: UIImageView!
    @IBOutlet private weak var seeAllTitle: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var viewModel: SRShowcaseResponseModel?
    
    var delegate: ShowCaseCellDelegate?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        seeAllTitle.text = Constants.seeAllTitle
        seeAllTitle.font = .regular12
        seeAllTitle.textColor = .textPCaption
        seeAllImage.image = .rightArrow
        
        titleLabel.font = .bold18
        
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
        delegate?.getShowCaseInfo(showcaseId: viewModel?.showcase?.id,title: viewModel?.showcase?.name)
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.getProductId(productId: viewModel?.products?[indexPath.row].id ?? "")
    }
    
}


extension ShowCaseCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
        //        descriptionLabel.text = bannerViewModel.description
    }
    
    
}
