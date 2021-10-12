//
//  ProductDetailViewController.swift
//  Kingfisher
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher

extension ProductDetailViewController : NibLoadable { }

public class ProductDetailViewController: BaseViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var pageControlContainer: UIView!
    
    @IBOutlet weak var container: UIView!
    private let viewModel : ProductDetailViewModel
    
    
    
    public override func setup() {
        
        collectionView.register(cellClass: ProductImageSliderCellCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        
        pageControl.numberOfPages = viewModel.getItemCount()
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        pageControlContainer.backgroundColor = .sliderBackground
        pageControlContainer.clipsToBounds = true
        pageControlContainer.layer.cornerRadius = pageControl.frame.height / 2
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
            pageControl.allowsContinuousInteraction = false
        }
    }

    public init(viewModel: ProductDetailViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: ProductDetailViewController.nibName, bundle: Bundle(for: ProductDetailViewController.self))
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = ProductDetailViewModel()
        super.init(coder: aDecoder)
    }

}

extension ProductDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageSliderCellCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductImageSliderCellCollectionViewCell
        return cell
    }
    
   
}

extension ProductDetailViewController : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ProductDetailViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
    }
}
