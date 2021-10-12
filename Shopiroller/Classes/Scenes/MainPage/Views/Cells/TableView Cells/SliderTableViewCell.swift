//
//  SliderTableViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 26.09.2021.
//

import UIKit
import Kingfisher


public class SliderTableViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControlContainer: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var viewModel: [SliderSlidesModel]?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(cellClass: SliderCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    
    func setup(viewModel : [SliderSlidesModel]?) {
        self.viewModel = viewModel
        pageControl.numberOfPages = viewModel?.count ?? 0
        collectionView.reloadData()
    }
    
}

extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.reuseIdentifier, for: indexPath) as! SliderCollectionViewCell
        cell.configureUI(model: self.viewModel?[indexPath.row])
        return cell
        
    }
    
    
}

extension SliderTableViewCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let height  = view.frame.height/2
        //        return CGSize(width: view.frame.width, height: height)
        return collectionView.frame.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let bannerViewModel = viewModel.bannerViewModel(at: indexPath.row)
        //        descriptionLabel.text = bannerViewModel.description
    }
    
}

extension SliderTableViewCell: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
    }
}

