//
//  SliderTableViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 26.09.2021.
//

import UIKit
import Kingfisher
import SafariServices

protocol SliderClickDelegate {
    func openProductDetail(id: String?)
    func openProductList(categoryId: String?)
    func openWebView(link : String?)
}


public class SliderTableViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControlContainer: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var viewModel: [SliderSlidesModel]?
    
    var delegate : SliderClickDelegate?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(cellClass: SliderCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
            pageControl.allowsContinuousInteraction = false
        }
    }
    
    
    func setup(viewModel : [SliderSlidesModel]?) {
        self.viewModel = viewModel
        pageControl.numberOfPages = viewModel?.count ?? 0
        if viewModel?.count != 1 , viewModel?.count != 0 {
            pageControl.customizePageControl(pageControlContainer)
        } else {
            pageControl.isHidden = true
        }
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
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navigationLink = viewModel?[indexPath.row].navigationLink
        switch viewModel?[indexPath.row].navigationType {
        case .category:
            delegate?.openProductList(categoryId: navigationLink)
        case .product:
            delegate?.openProductDetail(id: navigationLink)
        case .web:
            let url = URL(string: navigationLink ?? "")!
            let controller = SFSafariViewController(url: url)
            self.window?.rootViewController?.present(controller, animated: true, completion: nil)
            controller.delegate = self
        case .nothing:
            break
        default:
            break
        }
    }
    
}

extension SliderTableViewCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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

extension SliderTableViewCell : SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

