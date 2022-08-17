//
//  ProductDetailViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher
import LinkPresentation
import AVKit

private var lastContentOffset: CGFloat = 0

public struct ImageSlideModel {
    public let url: URL
    
    public var inputSource: InputSourceSR {
        return SRKingfisherSource(url: url)
    }
}

public class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {
    
    struct Constants {
        
        static var quantityTitle: String { return "e_commerce_product_detail_quantity".localized }
        
        static var descriptionTitle: String { return "e_commerce_product_detail_description".localized }
        
        static var returnExchangeTitle: String { return "e_commerce_product_detail_return_terms".localized }
        
        static var deliveryTitle: String { return "e_commerce_product_detail_delivery_conditions".localized }
        
        static var freeShippingText: String { return "e_commerce_list_free_shipping_badge".localized }
        
        static var soldOutText: String { return "e_commerce_list_sold_out_badge".localized }
        
        static var addToCartText: String { return "e_commerce_product_detail_buy_now".localized }
        
        static var shippingPriceText: String { return "e_commerce_product_detail_cargo_price".localized }
        
        static var backToProductButtonText: String { return "e_commerce_product_detail_maximum_product_limit_button".localized }
        
        static var backToProductsButtonText: String { return "e_commerce_product_detail_out_of_stock_button".localized }
        
        static var outOfStockTitle: String { return "e_commerce_product_detail_out_of_stock_title".localized }
        
        static var outOfStockDescription: String { return "e_commerce_product_detail_out_of_stock_description".localized }
        
        static var maxQuantityTitle: String { return "e_commerce_product_detail_maximum_product_limit_title".localized  }
        
        static var maxQuantityDescription: String { return "e_commerce_product_detail_maximum_product_limit_description".localized }
        
        static var pickerViewConfirmButton: String { return
            "e_commerce_general_ok_button_text".localized }
        
        static var pickerViewCancelButton: String { return
            "e_commerce_general_cancel_button_text".localized }
    }
    
    
    @IBOutlet private weak var topViewGradient: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var playVideoButton: UIButton!
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
    @IBOutlet private weak var variantStackView: UIStackView!
    
    @IBOutlet private weak var backgroundView: UIView!
    
    private let badgeView  = SRBadgeButton()
    
    private var toolBar = UIToolbar()
    private var pickerView  = UIPickerView()
    
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
        
        let pickerViewDismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(pickerViewCancelButtonTapped))
        self.view.addGestureRecognizer(pickerViewDismissTapGesture)
        pickerViewDismissTapGesture.cancelsTouchesInView = false
        pickerViewDismissTapGesture.delegate = self
        
        collectionView.register(cellClass: ProductImageSliderCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.top = -(view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        
        quantityTextField.text = "1"
        quantityTextField.font = .semiBold14
        quantityTextField.textColor = .textPrimary
        
        playVideoButton.isHidden = !viewModel.hasVideo()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        getProductDetail()
        getPaymentSettings()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let cardButton = UIBarButtonItem(customView: createNavigationItem(.generalCartIcon , .goToCard))
        let searchButton = UIBarButtonItem(customView: createNavigationItem(.searchIcon, .searchProduct))
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
    
    @IBAction func playVideoTapped(_ sender: Any) {
        if let url = viewModel.getVideoUrl() {
            let player = AVPlayer(url: url)
            let controller = AVPlayerViewController()
            controller.player = player
            present(controller, animated: true) {
                player.play()
            }
        }
    }
    
    @IBAction private func addToCardshowAnimation(_ sender: Any){
        addToCardButton.isUserInteractionEnabled = false
        if ShopirollerApp.shared.isUserLoggedIn() {
            if (viewModel.isVariantCanBeAdded()) {
                addProductToCart()
            } else {
                self.showPopUp(viewModel: self.viewModel.getVariantDoesNotExistPopUpViewModel())
            }
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
        self.view.makeToast(String(format: "e_commerce_product_detail_maximum_product_message".localized, count))
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
        setVariantUI()
        
    }
    
    private func setVariantUI() {
        if(!viewModel.isVariantEmpty()) {
            variantStackView.isHidden = false
            let textFields = viewModel.getVariantFields()
            for textField in textFields {
                let tapVariantButton = UITapGestureRecognizer(target: self, action: #selector(variantButtonTapped(_:)))
                textField.addGestureRecognizer(tapVariantButton)
                variantStackView.addArrangedSubview(textField)
            }
        }
    }
    
    @objc func variantButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedIndex = sender.view?.tag else {
            return
        }
        viewModel.setSelectedVariantTextFieldIndex(index: selectedIndex)
        self.view.subviews.contains(pickerView) ? removePickerViewFromSuperView() : createPickerView()
    }
    
    private func removePickerViewFromSuperView() {
        pickerView.removeFromSuperview()
        toolBar.removeFromSuperview()
    }
    
    private func createPickerView() {
        var items = [UIBarButtonItem]()
        
        let doneButton = UIBarButtonItem(title: Constants.pickerViewConfirmButton, style: .done, target: self, action: #selector(pickerViewDoneButtonTapped))
        doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        let cancelButton = UIBarButtonItem(title: Constants.pickerViewCancelButton, style: .plain, target: self, action: #selector(pickerViewCancelButtonTapped))
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        let toolbarTitle = UIBarButtonItem(title: viewModel.getPickerViewTitle(), style: .plain, target: self, action: nil)
        toolbarTitle.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        items.append(cancelButton)
        items.append(flexibleSpace)
        items.append(toolbarTitle)
        items.append(flexibleSpace)
        items.append(doneButton)
        
        var pickerViewModel = viewModel.getPickerViewModel(items: items)

        if (pickerViewModel?.pickerViewHeight ?? 0 > self.view.frame.height / 10 * 5 ) {
            pickerViewModel?.pickerViewHeight = (self.view.frame.height / 10 * 3).rounded(.toNearestOrEven)
        }
        
        pickerView = initializePickerView(pickerViewHeight: pickerViewModel?.pickerViewHeight)
        
        toolBar = initializeToolbar(pickerViewModel: pickerViewModel)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.view.addSubview(pickerView)
        
        self.view.addSubview(toolBar)
        
        pickerView.selectRow(viewModel.getSelectedVariantIndexForPickerView(), inComponent: 0, animated: true)
        
    }
    
    @objc func pickerViewDoneButtonTapped() {
        
        let pickerViewSelectedIndex = pickerView.selectedRow(inComponent: 0)
        
        viewModel.setSelectedVariantValue(index: pickerViewSelectedIndex, variantGroupIndex: viewModel.getSelectedVariantGroupIndex())
        
        for subview in variantStackView.subviews as [UIView] {
            if let srTextField = subview as? SRTextField {
                if srTextField.tag == viewModel.getSelectedVariantGroupIndex() {
                    let selectedVariant = viewModel.getVariantValueAt(index: pickerViewSelectedIndex, variantGroupIndex: viewModel.getSelectedVariantGroupIndex())
                    srTextField.getTextField().text = selectedVariant ?? ""
                    viewModel.setSelectedVariantForPickerView(pickerViewIndex: pickerViewSelectedIndex)
                }
            }
        }
        
        loadVariantImage(index: pickerViewSelectedIndex)
        setOutOfStockUI()
        setDiscountUI()
        setFreeShippingUI()
        removePickerViewFromSuperView()
    }
    
    @objc func pickerViewCancelButtonTapped() {
        removePickerViewFromSuperView()
    }
    
    private func loadVariantImage(index: Int) {
        let index = viewModel.getImageIndexAtVariant(index: index, variantGroupIndex: viewModel.getSelectedVariantGroupIndex())
        collectionView.selectItem(at: NSIndexPath(item: index, section: 0) as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        pageControl.currentPage = index
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
        } else {
            self.addToCardButton.isUserInteractionEnabled = true
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
        fullScreenController.initialPage = indexPath.row
        fullScreenController.delegate = self
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

extension ProductDetailViewController: SRFullScreenSlideshowDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func getCurrentIndex(index: Int) {
        collectionView.selectItem(at: NSIndexPath(item: index, section: 0) as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
        pageControl.currentPage = index
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getVariantListCountAt(index: viewModel.getSelectedVariantGroupIndex())
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let variants = viewModel.getVariantListAt(index: viewModel.getSelectedVariantGroupIndex()) else {
            return ""
        }
        return variants[row].value
    }
    
}


extension ProductDetailViewController : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view {
            if !((touchedView.isDescendant(of: pickerView)) || (touchedView.isDescendant(of: toolBar))) {
                removePickerViewFromSuperView()
            } else {
                return false
            }
        }
        return true
    }
    
}
