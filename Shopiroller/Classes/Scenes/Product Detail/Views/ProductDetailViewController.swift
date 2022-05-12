//
//  ProductDetailViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher
import LinkPresentation

private var lastContentOffset: CGFloat = 0

public struct ImageSlideModel {
    public let url: URL
    
    public var inputSource: InputSourceSR {
        return SRKingfisherSource(url: url)
    }
}

public class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {
    
    struct Constants {
        
        static var quantityTitle: String { return "quantity-title".localized }
        
        static var descriptionTitle: String { return "description-title".localized }
        
        static var returnExchangeTitle: String { return "return-exchange-terms-title".localized }
        
        static var deliveryTitle: String { return "delivery-terms-title".localized }
        
        static var freeShippingText: String { return "free-shipping-text".localized }
        
        static var soldOutText: String { return "sold-out-text".localized }
        
        static var addToCartText: String { return "add-to-cart".localized }
        
        static var shippingPriceText: String { return "shipping-price-text".localized }
        
        static var backToProductButtonText: String { return "product-detail-back-to-product-button-text".localized }
        
        static var backToProductsButtonText: String { return "product-detail-back-to-product-list-button-text".localized }
        
        static var outOfStockTitle: String { return "product-detail-out-of-stock-title".localized }
        
        static var outOfStockDescription: String { return "product-detail-out-of-stock-description".localized }
        
        static var maxQuantityTitle: String { return "product-detail-maximum-product-quantity-title".localized  }
        
        static var maxQuantityDescription: String { return "product-detail-maximum-product-quantity-description".localized }
        
    }
    
    
    @IBOutlet private weak var topViewGradient: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
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
    
    @IBOutlet private weak var addToCardButton: SRButton!
    @IBOutlet private weak var addToCardContainer: UIView!
    @IBOutlet private weak var checkmarkImage: UIImageView!
    
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
    
    @IBOutlet private weak var quantityTextField: UITextField!
    @IBOutlet private weak var productBrandImage: UIImageView!
    @IBOutlet private weak var shippingPriceContainerConstraint: NSLayoutConstraint!
    
    private let badgeView  = SRBadgeButton()
    
    public init(viewModel: ProductDetailViewModel) {
        super.init(viewModel: viewModel, nibName: ProductDetailViewController.nibName, bundle: Bundle(for: ProductDetailViewController.self))
    }
    
    public override func setup() {
        super.setup()
        view.backgroundColor = .white
        
        checkmarkImage.tintColor = .white
        
        scrollView.delegate = self
        
        descriptionContainerImage.image = UIImage(systemName: "chevron.right")
        descriptionContainerImage.tintColor = .black
        descriptionContainer.layer.cornerRadius = 8
        descriptionContainer.layer.borderWidth = 1
        descriptionContainer.layer.borderColor = UIColor.borderColor.cgColor
        descriptionContainer.layer.masksToBounds = true
        descriptionContainer.clipsToBounds = true
        descriptionTitleLabel.text = Constants.descriptionTitle
        descriptionTitleLabel.font = .semiBold14
        
        returnExchangeContainer.makeCardView()
        returnExchangeContainer.backgroundColor = .buttonLight
        returnExchangeContainer.clipsToBounds = true
        returnExchangeImage.image = UIImage(systemName: "chevron.right")
        returnExchangeImage.tintColor = .black
        returnExchangeTitleLabel.font = .semiBold14
        
        deliveryTermsContainer.makeCardView()
        deliveryTermsContainer.backgroundColor = .buttonLight
        deliveryTermsContainer.clipsToBounds = true
        deliveryContainerImage.image = UIImage(systemName: "chevron.right")
        deliveryContainerImage.tintColor = .black
        deliveryTermsTitleLabel.font = .semiBold14
        
        quantityContainer.makeCardView()
        quantityContainer.backgroundColor = .buttonLight
        quantityContainer.clipsToBounds = true
        quantityTextField.delegate = self
        quantityTitleLabel.text = Constants.quantityTitle
        quantityTextField.keyboardType = .numberPad
        quantityTitleLabel.font = .semiBold14
        
        
        shippingPriceContainer.makeCardView()
        shippingPriceContainer.clipsToBounds = true
        shippingPriceContainer.backgroundColor = .badgeWarningInfo
        
        addToCardContainer.backgroundColor = .black
        addToCardButton.tintColor = .white
        addToCardButton.setTitleColor(.white)
        addToCardButton.titleLabel?.font = .semiBold16
        
        if #available(iOS 15.0, *) {
            addToCardButton.configuration?.imagePadding = 15
        } else {
            addToCardButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 35)
        }
        
        let sumQuantityRecognizer = UITapGestureRecognizer(target: self, action: #selector(sumImageTapped(_:)))
        sumImage.addGestureRecognizer(sumQuantityRecognizer)
        
        sumImage.tintColor = .black
        sumImage.isUserInteractionEnabled = true
        
        let minusQuantityRecognizer = UITapGestureRecognizer(target: self, action: #selector(minusImageTapped(_:)))
        minusImage.addGestureRecognizer(minusQuantityRecognizer)
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
        collectionView.contentInset.top = -(view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
                
        getProductDetail()
        
        getPaymentSettings()
        
        quantityTextField.text = "1"
        quantityTextField.font = .semiBold14
        quantityTextField.textColor = .textPrimary
     
        self.view.isHidden = true
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let cardButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon , .goToCard))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon, .searchProduct))
//        let shareButton = createNavigationItem(UIImage(systemName: "square.and.arrow.up"))
//        shareButton.addTarget(self, action: #selector(shareProduct), for: .touchUpInside)
        updateNavigationBar(rightBarButtonItems: [searchButton, cardButton], isBackButtonActive: true)
        cardButton.customView?.addSubview(badgeView)
    }
    
    @objc func shareProduct() {
        //TODO APP LINK
        let myWebsite = NSURL(string: "https://apps.apple.com/us/app/shopirollerg/id" )
        let objectsToShare: [Any] = [viewModel.getTitle(), viewModel.getPrice(), myWebsite]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCount()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBadgeCount), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateShoppighCartObserve), object: nil)
        setTransparentNavigationBar()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        initializeNavigationBar()
        
        navigationController!.navigationBar.setBackgroundImage(backgroundImage, for: .default)
        navigationController?.navigationBar.isTranslucent = false
        if let apperance = appearance {
            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
        }
        navigationController!.navigationBar.backgroundColor = backgroundColor
        
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            navigationController?.navigationBar.isTranslucent = false
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = ShopirollerApp.shared.theme.navigationBarTintColor
            let textAttributes = [NSAttributedString.Key.foregroundColor: ShopirollerApp.shared.theme.navigationTitleTintColor]
            appearance.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    @objc func updateBadgeCount() {
        badgeView.badgeCount = SRAppContext.shoppingCartCount
    }
    
    @IBAction private func addToCardshowAnimation(_ sender: Any){
        addToCardButton.isUserInteractionEnabled = false
        if ShopirollerApp.shared.isUserLoggedIn() {
            addProductToCart()
        } else {
            ShopirollerApp.shared.delegate?.userLoginNeeded(navigationController: self.navigationController)
            addToCardButton.isUserInteractionEnabled = true
        }
    }
    
    private func showAddProductAnimation() {
        if checkmarkImage.isHidden == true {
            UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
                self.addToCardButton.frame.origin.y += 70
                self.checkmarkImage.isHidden = false
                self.checkmarkImage.frame.origin.y += 70
            }, completion: {_ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.hideAddProductAnimation()
                }
            })
        }
    }
    
    
    private func hideAddProductAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.addToCardButton.frame.origin.y = 0
            self.checkmarkImage.frame.origin.y = self.checkmarkImage.frame.origin.y - 70
        }, completion: {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.checkmarkImage.isHidden = true
                self.addToCardButton.isUserInteractionEnabled = true
            }
        })
        
    }
    
    var backgroundImage: UIImage?
    var backgroundColor: UIColor?
    var appearance: UINavigationBarAppearance?
    
    private func setTransparentNavigationBar() {
        backgroundColor = navigationController!.navigationBar.backgroundColor
        navigationController!.navigationBar.backgroundColor = UIColor.clear
        backgroundImage = navigationController!.navigationBar.backgroundImage(for: .default)
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        appearance = navigationController?.navigationBar.standardAppearance
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            navigationController?.navigationBar.isTranslucent = true
            appearance.configureWithTransparentBackground()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        topViewGradient.makeGradientLayer()
    }
    
    private func getProductDetail() {
        viewModel.getProductDetail(success: {
            [weak self] in
            guard let self = self else { return }
            self.setUI()
            self.view.isHidden = false
            self.collectionView.reloadData()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showPopUp(viewModel: self.viewModel.getProductNotFoundPopUpViewModel())
        }
    }
    
    
    private func getPaymentSettings() {
        viewModel.getProductTerms(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getCount() {
        viewModel.getShoppingCartCount(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func addProductToCart() {
        viewModel.addProductToCart(success: {
            [weak self] in
            guard let self = self else { return }
            self.showAddProductAnimation()
            self.navigationController?.viewWillLayoutSubviews()
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            if errorViewModel.message == SRAppConstants.URLResults.productMaxQuantityPerOrderExceeded {
                self.showPopUp(viewModel: self.viewModel.getMaxQuantityPopUpViewModel())
                self.addToCardButton.isUserInteractionEnabled = true
            } else if errorViewModel.message == SRAppConstants.URLResults.productMaxStockExceeded {
                self.showPopUp(viewModel: self.viewModel.getSoldOutPopUpViewModel())
            } else if self.viewModel.isUserFriendlyMessage() {
                self.view.makeToast(errorViewModel.message)
            }
        }
    }
    
    @objc private func sumImageTapped(_ sender: Any) {
        sumImage.makeAnimation()
        if viewModel.isProductReachMaximumAddLimit() {
            setMaxItemQuantitySituation("\(viewModel.quantityCount)")
        } else {
            viewModel.quantityCount += 1
            minusImage.isUserInteractionEnabled = true
            sumImage.isUserInteractionEnabled = true
            quantityTextField.text = "\(viewModel.quantityCount)"
        }
    }
    
    private func setMaxItemQuantitySituation(_ count: String) {
        self.view.makeToast(String(format: "shopping_cell_maximum_product_message".localized, count))
    }
    
    @objc private func minusImageTapped(_ sender: Any) {
        minusImage.makeAnimation()
        if quantityTextField.text == "1" {
            return
        }else {
            viewModel.quantityCount -= 1
            quantityTextField.text = "\(viewModel.quantityCount)"
        }
    }
    
    @IBAction func textFieldEndEditing(_ textField: UITextField) {
        switch textField {
        case quantityTextField:
            viewModel.quantityCount = NumberFormatter().number(from: textField.text ?? "1")?.intValue ?? 1
            if(textField.text == "" || textField.text == nil) {
                quantityTextField.text = "1"
            } else if ((Int(textField.text ?? "") ?? 0 > viewModel.getMaxQuantity())) {
                setMaxItemQuantitySituation(viewModel.getMaxQuantityCount())
                quantityTextField.text = "\(viewModel.getMaxQuantity())"
                viewModel.quantityCount = NumberFormatter().number(from: textField.text ?? "1")?.intValue ?? 1
            } else if ((Int(textField.text ?? "") ?? 0 > viewModel.getStockCount())) {
                setMaxItemQuantitySituation("\(viewModel.getStockCount())")
                quantityTextField.text = "\(viewModel.getStockCount())"
                viewModel.quantityCount = NumberFormatter().number(from: textField.text ?? "1")?.intValue ?? 1
            } else if (textField.text?.first == "0") {
                quantityTextField.text = "1"
                viewModel.quantityCount = NumberFormatter().number(from: textField.text ?? "1")?.intValue ?? 1
            }
        default:
            break
        }
    }
    
    @objc private func descriptionContainerTapped(_ sender: Any) {
        let vc = WebViewController(viewModel: WebViewViewModel(webViewHtml: viewModel.getDescription() ?? ""))
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func returnExchangeContainerTapped(_ sender: Any) {
        showPopUp(viewModel: viewModel.getReturnExchangePopUpViewModel())
    }
    
    @objc private func deliveryTermsContainerTapped(_ sender: Any) {
        showPopUp(viewModel: viewModel.getDeliveryTermsPopUpViewModel())
    }
    
    private func setUI() {
        
        returnExchangeTitleLabel.text = viewModel.getCancellationProdecureTitle()
        deliveryTermsTitleLabel.text = viewModel.getDeliveryConditionsTitle()
        
        productTitleLabel.textColor = .textPrimary
        productTitleLabel.font = .bold24
        productTitleLabel.text = viewModel.getTitle()
        
        self.pageControl.numberOfPages = viewModel.getItemCount() ?? 0
        
        if viewModel.getItemCount() != 1 , viewModel.getItemCount() != 0 {
            pageControl.customizePageControl(pageControlContainer)
        } else {
            pageControl.isHidden = true
        }
        
        if let brandImage = viewModel.getBrandImage() {
            productBrandImage.kf.setImage(with: URL(string: brandImage))
        } else {
            productBrandImage.isHidden = true
        }
        
        setOutOfStockUI()
        setFreeShippingUI()
        setDiscountUI()
        
    }
    
    private func setOutOfStockUI() {
        
        if viewModel.isOutofStock() {
            addToCardButton.isUserInteractionEnabled = false
            addToCardButton.setImage(nil)
            addToCardButton.setTitle(Constants.soldOutText)
            addToCardButton.titleLabel?.text = Constants.soldOutText
            soldOutContainer.isHidden = false
            soldOutContainer.makeCardView()
            soldOutContainer.backgroundColor = .badgeWarningInfo
            soldOutLabel.textColor = .black
            soldOutLabel.text = Constants.soldOutText
            quantityContainer.isHidden = true
        } else {
            addToCardButton.isUserInteractionEnabled = true
            addToCardButton.setTitle(Constants.addToCartText)
            addToCardButton.setImage(UIImage(systemName: "cart"))
            soldOutContainer.isHidden = true
            quantityContainer.isHidden = false
        }
    }
    
    private func setFreeShippingUI() {
        
        shippingPriceContainer.isHidden = viewModel.isUseFixPrice()
        
        if viewModel.isShippingFree() {
            freeShippingContainer.isHidden = false
            shippingPriceContainerConstraint.constant = 0
            freeShippingContainer.makeCardView()
            freeShippingContainer.backgroundColor = .black
            freeShippingLabel.textColor = .white
            freeShippingLabel.font = .bold10
            freeShippingLabel.text = Constants.freeShippingText.uppercased()
        } else {
            freeShippingContainer.isHidden = true
            shippingPriceLabel.attributedText = String().makeBoldString(boldText: ECommerceUtil.getFormattedPrice(price: Double(viewModel.getShippingPrice()), currency: viewModel.getCurrency()), normalText: Constants.shippingPriceText,isReverse: true)
            shippingImage.image = .cargoShippingImage
            shippingImage.tintColor = .pinkishTan
        }
    }
    
    private func setDiscountUI() {
        
        if viewModel.hasDiscount() {
            discountContainer.isHidden = false
            productNewPrice.isHidden = false
            discountContainer.makeCardView()
            discountContainer.layer.masksToBounds = true
            discountContainer.backgroundColor = .badgeSecondary
            discountLabel.text = viewModel.discount
            discountLabel.font = .bold14
            productOldPrice.textColor = .textPCaption
            productOldPrice.font = .medium14
            productOldPrice.attributedText = viewModel.getPrice().makeStrokeCurrency(currency: viewModel.getCurrency())
            productNewPrice.text = ECommerceUtil.getFormattedPrice(price: Double(viewModel.getCampaignPrice()), currency: viewModel.getCurrency())
            productNewPrice.font = .semiBold20
        }else{
            discountContainer.isHidden = true
            productNewPrice.isHidden = true
            productOldPrice.text = ECommerceUtil.getFormattedPrice(price: Double(viewModel.getPrice()), currency: viewModel.getCurrency())
            productOldPrice.textColor = .black
            productOldPrice.font = .semiBold20
        }
    }
    
    private func showSoldOutPopUp() {
        showPopUp(viewModel: viewModel.getSoldOutPopUpViewModel())
    }
    
    private func showPopUp(viewModel: PopUpViewModel) {
        let vc = PopUpViewViewController(viewModel: viewModel)
        vc.delegate = self
        popUp(vc, completion: nil)
    }
}

extension ProductDetailViewController : PopUpViewViewControllerDelegate {
    func firstButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController) {
        if(viewModel.isStateSoldOut()) {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            popToRoot(animated: false, completion: nil)
        }
    }
    
    func secondButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController) {
        if let navigationController = self.navigationController {
            navigationController.dismiss(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
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
        let fullScreenController = SRFullScreenSlideshowViewController()
        var imagesArray : [ImageSlideModel] = [ImageSlideModel]()
        let images = viewModel.getImageArray()
        fullScreenController.slideshow.pageIndicator?.view.tintColor = .white
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

extension ProductDetailViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == quantityTextField) {
            guard let currentText = textField.text else { return true }
            return (currentText + string).count <= 4
        }
        return true
    }
}

