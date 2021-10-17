//
//  ProductDetailViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher
import ImageSlideshow

extension ProductDetailViewController : NibLoadable { }

public class ProductDetailViewController: BaseViewController {
    
    private struct Constants {
 
        static var quantityTitle: String { return "quantity-title".localized }
        
        static var descriptionTitle: String { return "description-title".localized }
        
        static var returnExchangeTitle: String { return "return-exchange-terms-title".localized }
        
        static var deliveryTitle: String { return "delivery-terms-title".localized }
        
        static var freeShippingText: String { return "free-shipping-text".localized }
        
        static var soldOutText: String { return "sold-out-text".localized }
        
        static var addToCartText: String { return "add-to-cart".localized }
        
        static var shippingPriceText: String { return "shipping-price-text".localized }
    }
    
    public struct ImageSlideModel {
        public let url: URL
        
        public var inputSource: InputSource {
            return KingfisherSource(url: url)
        }
    }


    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var pageControlContainer: UIView!
    
    @IBOutlet private weak var situationContainer: UIStackView!
    @IBOutlet private weak var soldOutContainer: UIView!
    @IBOutlet private weak var soldOutLabel: UILabel!

    @IBOutlet private weak var freeShippingContainer: UIView!
    @IBOutlet private weak var freeShippingLabel: UILabel!
    
    @IBOutlet private weak var productTitleLabel: UILabel!
   
    @IBOutlet private weak var productNewPrice: UILabel!
    @IBOutlet private weak var productOldPrice: UILabel!
    @IBOutlet private weak var discountContainer: UIView!
    @IBOutlet private weak var discountLabel: UILabel!
    
    @IBOutlet private weak var addToCardImage: UIImageView!
    @IBOutlet private weak var addToCardTitleLabel: UILabel!
    @IBOutlet private weak var addToCardContainer: UIView!
    
    @IBOutlet private weak var deliveryTermsContainer: UIView!
    @IBOutlet private weak var deliveryTermsTitleLabel: UILabel!
    @IBOutlet private weak var deliveryContainerImage: UIImageView!
    
    @IBOutlet private weak var returnExchangeContainer: UIView!
    @IBOutlet private weak var returnExchangeTitleLabel: UILabel!
    @IBOutlet private weak var returnExchangeImage: UIImageView!
    
    @IBOutlet private weak var descriptionContainer: UIView!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var descriptionContainerImage: UIImageView!
    
    @IBOutlet private weak var sumImage: UIImageView!
    @IBOutlet private weak var minusImage: UIImageView!
    @IBOutlet private weak var quantityContainer: UIView!
    @IBOutlet private weak var quantityTitleLabel: UILabel!
    @IBOutlet private weak var quantityCountContainer: UIView!
    
    @IBOutlet private weak var shippingPriceContainer: UIView!
    @IBOutlet private weak var shippingPriceLabel: UILabel!
    @IBOutlet private weak var shippingImage: UIImageView!
    
    @IBOutlet private weak var quantityCountLabel: UILabel!
    @IBOutlet private weak var productBrandImage: UIImageView!
    @IBOutlet private weak var shippingPriceContainerConstraint: NSLayoutConstraint!
    
    private let viewModel : ProductDetailViewModel
    
    public init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ProductDetailViewController.nibName, bundle: Bundle(for: ProductDetailViewController.self))
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = ProductDetailViewModel()
        super.init(coder: aDecoder)
    }
    
    public override func setup() {
        super.setup()
        
        view.backgroundColor = .white
        
        descriptionContainerImage.image = UIImage(systemName: "chevron.right")
        descriptionContainerImage.tintColor = .black
        descriptionContainer.layer.cornerRadius = 8
        descriptionContainer.layer.borderWidth = 1
        descriptionContainer.layer.borderColor = UIColor.borderColor.cgColor
        descriptionContainer.layer.masksToBounds = true
        descriptionContainer.clipsToBounds = true
        descriptionTitleLabel.text = Constants.descriptionTitle
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)

        returnExchangeContainer.makeCardView()
        returnExchangeContainer.backgroundColor = .buttonLight
        returnExchangeContainer.clipsToBounds = true
        returnExchangeImage.image = UIImage(systemName: "chevron.right")
        returnExchangeImage.tintColor = .black
        returnExchangeTitleLabel.text = Constants.returnExchangeTitle
        returnExchangeTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        deliveryTermsContainer.makeCardView()
        deliveryTermsContainer.backgroundColor = .buttonLight
        deliveryTermsContainer.clipsToBounds = true
        deliveryContainerImage.image = UIImage(systemName: "chevron.right")
        deliveryContainerImage.tintColor = .black
        deliveryTermsTitleLabel.text = Constants.deliveryTitle
        deliveryTermsTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        quantityContainer.makeCardView()
        quantityContainer.backgroundColor = .buttonLight
        quantityContainer.clipsToBounds = true
        quantityTitleLabel.text = Constants.quantityTitle
        quantityTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        
        shippingPriceContainer.makeCardView()
        shippingPriceContainer.clipsToBounds = true
        shippingPriceContainer.backgroundColor = .badgeWarningInfo
        
        addToCardContainer.backgroundColor = .black
        addToCardTitleLabel.textColor = .white
        addToCardTitleLabel.text = Constants.addToCartText
        addToCardTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        addToCardImage.tintColor = .white
        addToCardImage.image = UIImage(systemName: "cart")
        
        let sumQuantityRecognizer = UITapGestureRecognizer(target: self, action: #selector(sumImageTapped(_:)))
        sumImage.addGestureRecognizer(sumQuantityRecognizer)
        sumImage.image = UIImage(systemName: "plus.circle")
        sumImage.tintColor = .black
        sumImage.isUserInteractionEnabled = true
        
        let minusQuantityRecognizer = UITapGestureRecognizer(target: self, action: #selector(minusImageTapped(_:)))
        minusImage.addGestureRecognizer(minusQuantityRecognizer)
        minusImage.image = UIImage(systemName: "minus.circle")
        minusImage.tintColor = .black
        minusImage.isUserInteractionEnabled = true
        
        
        let descriptionRecognizer = UITapGestureRecognizer(target: self, action: #selector(descriptionContainerTapped(_:)))
        descriptionContainer.addGestureRecognizer(descriptionRecognizer)
        
        let returnExchangeRecognizer = UITapGestureRecognizer(target: self, action: #selector(returnExchangeContainerTapped(_:)))
        returnExchangeContainer.addGestureRecognizer(returnExchangeRecognizer)
        
        let deliveryRecognizer = UITapGestureRecognizer(target: self, action: #selector(deliveryTermsContainerTapped(_:)))
        deliveryTermsContainer.addGestureRecognizer(deliveryRecognizer)
        
        
        
            
        collectionView.register(cellClass: ProductImageSliderCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        
        pageControl.customizePageControl(pageControl, pageControlContainer: pageControlContainer)
        getProductDetail()
        
        getPaymentSettings()
        
        quantityCountLabel.text = "1"
    }
    
    
    private func getProductDetail() {
        viewModel.getProductDetail(succes: {
            [weak self] in
            guard let self = self else { return }
            self.pageControl.numberOfPages = self.viewModel.getItemCount() ?? 0
            self.setUI()
            self.collectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    
    private func getPaymentSettings() {
        viewModel.getProductTerms(succes: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    @objc private func sumImageTapped(_ sender: Any) {
        sumImage.makeAnimation()
        if viewModel.isQuantityMax() {
            sumImage.isUserInteractionEnabled = false
        } else {
            minusImage.isUserInteractionEnabled = true
            sumImage.isUserInteractionEnabled = true
            viewModel.quantityCount += 1
            quantityCountLabel.text = "\(viewModel.quantityCount)"
        }
    }
    
    @objc private func minusImageTapped(_ sender: Any) {
        minusImage.makeAnimation()
        if quantityCountLabel.text == "1" {
            return
        }else {
            viewModel.quantityCount -= 1
            quantityCountLabel.text = "\(viewModel.quantityCount)"
        }
    }
    
    @objc private func descriptionContainerTapped(_ sender: Any) {
        let vc = WebViewController(viewModel: WebViewViewModel(webViewUrl: viewModel.getDescriptionUrl() ?? ""))
        self.present(vc,animated: true, completion: nil)
    }
    
    @objc private func returnExchangeContainerTapped(_ sender: Any) {
        let vc = PopUpViewViewController(viewModel: PopUpViewModel(image: .paymentFailed, title: "Return Exchange", description: "You are clearing all  products in shopping cart now." , firstButton: popUpButton(title: "Back To Product", type: .dismiss, viewController: nil, buttonType: .darkButton), secondButton: nil))
        self.popUp(vc, completion: nil)
    }
    
    @objc private func deliveryTermsContainerTapped(_ sender: Any) {
        let vc = PopUpViewViewController(viewModel: PopUpViewModel(image: .paymentFailed, title: "Delivery Terms", description: viewModel.getDeliveryTerms()?.localized , firstButton: popUpButton(title: "Back To Product", type: .dismiss, viewController: nil, buttonType: .darkButton), secondButton: nil))
        self.popUp(vc, completion: nil)
    }
    
    private func setUI() {
        productTitleLabel.text = viewModel.getTitle()
        
        if let brandImage = viewModel.getBrandImage() {
            productBrandImage.kf.setImage(with: URL(string: brandImage))
        }
        
        if viewModel.hasDiscount() {
            discountContainer.isHidden = false
            productNewPrice.isHidden = false
            discountContainer.makeCardView()
            discountContainer.layer.masksToBounds = true
            discountContainer.backgroundColor = .badgeSecondary
            discountLabel.text = viewModel.discount
            productOldPrice.textColor = .textPCaption
            productOldPrice.attributedText = viewModel.getPrice().makeStrokeCurrency(viewModel.getPrice(), currency: viewModel.getCurrency())
            productNewPrice.text = "\(viewModel.getCampaignPrice())" + " " + viewModel.getCurrency()
        }else{
            discountContainer.isHidden = true
            productNewPrice.isHidden = true
            productOldPrice.text = "\(viewModel.getPrice())"
            productOldPrice.textColor = .black
            productOldPrice.font.withSize(17)
        }
        
        situationContainer.isHidden = !viewModel.isShippingFree() || !viewModel.isOutofStock()
        
        if viewModel.isShippingFree() {
            freeShippingContainer.isHidden = false
            shippingPriceContainer.isHidden = true
            shippingPriceContainerConstraint.constant = 0
            freeShippingContainer.makeCardView()
            freeShippingContainer.backgroundColor = .black
            freeShippingLabel.textColor = .white
            freeShippingLabel.text = Constants.freeShippingText
        }else {
            freeShippingContainer.isHidden = true
            shippingPriceContainer.isHidden = false
            let attributedShippingPrice = Constants.shippingPriceText.replacingOccurrences(of: "XX", with: "#\(viewModel.getShippingPrice())#").makeShippingPriceBold(viewModel.getCurrency()).stringWithString(stringToReplace: "#", replacedWithString: "")
            shippingPriceLabel.attributedText = attributedShippingPrice
            shippingImage.image = .cargoShippingImage
            shippingImage.tintColor = .pinkishTan
        }
        
        if viewModel.isOutofStock() {
            soldOutContainer.isHidden = false
            soldOutContainer.makeCardView()
            soldOutContainer.backgroundColor = .badgeWarningInfo
            soldOutLabel.textColor = .black
            soldOutLabel.text = Constants.soldOutText
            quantityContainer.isHidden = true
            showSoldOutPopUp()
        }else{
            soldOutContainer.isHidden = true
            quantityContainer.isHidden = false
            addToCardImage.isHidden = true
            addToCardTitleLabel.text = Constants.soldOutText
        }
    }
    
    private func showSoldOutPopUp() {
        let vc = PopUpViewViewController(viewModel: PopUpViewModel(image: .paymentFailed, title: "Delivery Terms", description: viewModel.getDeliveryTerms()?.localized , firstButton: popUpButton(title: "Back To Product", type: .dismiss, viewController: nil, buttonType: .darkButton), secondButton: nil))
        popUp(vc, completion: nil)
    }    
}




extension ProductDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemCount() ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageSliderCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductImageSliderCollectionViewCell
        cell.configurecell(images: viewModel.getImages(position: indexPath.row))
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenController = FullScreenSlideshowViewController()
        var imagesArray : [ImageSlideModel] = [ImageSlideModel]()
        let images = viewModel.getImageArray()
        // removed html prepare code
        fullScreenController.initialPage = indexPath.row
        images?.forEach{ image in
            imagesArray.append(ImageSlideModel(url: URL(string: image.normal ?? "")!))
        }
        fullScreenController.inputs = imagesArray.map{ $0.inputSource }
        present(fullScreenController, animated: true, completion: nil)
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

extension ProductDetailViewController: ImageSlideshowDelegate {
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}


