//
//  CheckOutInfoViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import Lottie
import SafariServices

class CheckOutInfoViewController: BaseViewController<CheckOutInfoViewModel> {
    
    
    private struct Constants {
        static var shoppingCardViewTitle: String { return "e_commerce_order_summary_cart_title".localized }
        static var paymentCardViewTitle: String { return "e_commerce_order_summary_payment_title".localized }
        static var billingAddressCardViewTitle: String { return "e_commerce_order_summary_invoice_address_title".localized }
        static var deliveryAddressCardViewTitle: String { return "e_commerce_order_summary_delivery_address_title".localized }
        static var confirmOrderButtonTitle: String { return "e_commerce_order_summary_action_confirm_order".localized }
        static var agreeTermsAndConditionsText: String { return "e_commerce_order_summary_agreement_description".localized }
        static var userOrderNotePlaceholderText: String { return
            "e_commerce_order_summary_order_note_hint".localized
        }
    }
    
    @IBOutlet private weak var mainContainerView: UIView!
    @IBOutlet private weak var shoppingCardViewImage: UIImageView!
    @IBOutlet private weak var shoppingCardViewTitle: UILabel!
    @IBOutlet private weak var shoppingCardViewDescription: UILabel!
    @IBOutlet private weak var shoppingCardViewEditButton: UIButton!
    @IBOutlet private weak var shoppingCardViewContainer: UIView!
    @IBOutlet private weak var paymentCardViewImage: UIImageView!
    @IBOutlet private weak var paymentCardViewTitle: UILabel!
    @IBOutlet private weak var paymentCardViewDescription: UILabel!
    @IBOutlet private weak var paymentCardViewEditButton: UIButton!
    @IBOutlet private weak var paymentCardViewContainer: UIView!
    @IBOutlet private weak var billingAddressViewImage: UIImageView!
    @IBOutlet private weak var billingAddressViewTitle: UILabel!
    @IBOutlet private weak var billingAddressViewDescription: UILabel!
    @IBOutlet private weak var billingAddressCardViewEditButton: UIButton!
    @IBOutlet private weak var billingAddressCardViewContainer: UIView!
    @IBOutlet private weak var deliveryAddressCardImage: UIImageView!
    @IBOutlet private weak var deliveryAddressCardTitle: UILabel!
    @IBOutlet private weak var deliveryAddressCardDescription: UILabel!
    @IBOutlet private weak var deliveryAddressCardEditButton: UIButton!
    @IBOutlet private weak var deliveryAddressCardViewContainer: UIView!
    @IBOutlet private weak var orderNoteContainerView: UIView!
    @IBOutlet private weak var orderNote: UITextView!
    @IBOutlet private weak var bottomPriceView: BottomPriceView!
    @IBOutlet private weak var agreeTermsButton: UIButton!
    @IBOutlet private weak var agreeTermsTitle: UILabel!
    @IBOutlet private weak var agreeTermsTitleContainer: UIView!
    @IBOutlet private weak var animationView: AnimationView!
    
    
    private var isShoppingCartPopUp : Bool = true
    
    private let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
    
    
    weak var delegate: CheckOutProgressPageDelegate?
    
    init(viewModel: CheckOutInfoViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutInfoViewController.nibName, bundle: Bundle(for: CheckOutInfoViewController.self))
    }
    
    override func setup() {
        super.setup()
                
        shoppingCardViewContainer.layer.cornerRadius = 6
        shoppingCardViewContainer.backgroundColor = .buttonLight
        shoppingCardViewTitle.text = Constants.shoppingCardViewTitle
        shoppingCardViewTitle.font = .semiBold14
        shoppingCardViewDescription.font = .regular12
        shoppingCardViewDescription.textColor = .textPCaption
        shoppingCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        shoppingCardViewEditButton.tintColor = .textPCaption
        shoppingCardViewImage.image = .cartIcon
        
        paymentCardViewContainer.layer.cornerRadius = 6
        paymentCardViewContainer.backgroundColor = .buttonLight
        paymentCardViewTitle.text = Constants.paymentCardViewTitle
        paymentCardViewTitle.font = .semiBold14
        paymentCardViewDescription.font = .regular12
        paymentCardViewDescription.textColor = .textPCaption
        paymentCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        paymentCardViewEditButton.tintColor = .textPCaption
        paymentCardViewImage.image = .paymentIcon
        
        billingAddressCardViewContainer.layer.cornerRadius = 6
        billingAddressCardViewContainer.backgroundColor = .buttonLight
        billingAddressViewTitle.text = Constants.billingAddressCardViewTitle
        billingAddressViewTitle.font = .semiBold14
        billingAddressViewDescription.font = .regular12
        billingAddressViewDescription.textColor = .textPCaption
        billingAddressCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        billingAddressCardViewEditButton.tintColor = .textPCaption
        billingAddressViewImage.image = .billingAddressIcon
        
        deliveryAddressCardViewContainer.layer.cornerRadius = 6
        deliveryAddressCardViewContainer.backgroundColor = .buttonLight
        deliveryAddressCardTitle.text = Constants.deliveryAddressCardViewTitle
        deliveryAddressCardTitle.font = .semiBold14
        deliveryAddressCardDescription.font = .regular12
        deliveryAddressCardDescription.textColor = .textPCaption
        deliveryAddressCardEditButton.setImage(UIImage(systemName: "pencil"))
        deliveryAddressCardEditButton.tintColor = .textPCaption
        deliveryAddressCardImage.image = .deliveryAddressIcon
        
        agreeTermsButton.setImage(UIImage(systemName: "circle"))
        agreeTermsButton.imageView?.tintColor = .veryLightPink
        
        agreeTermsTitle.attributedText = Constants.agreeTermsAndConditionsText.convertHtml()
        agreeTermsTitle.font = .regular12
        agreeTermsTitle.textColor = .textPCaption
        let agreeTapGesture = UITapGestureRecognizer(target: self, action: #selector(getTerms))
        agreeTermsTitleContainer.addGestureRecognizer(agreeTapGesture)
        
        orderNoteContainerView.backgroundColor = .buttonLight
        orderNoteContainerView.layer.cornerRadius = 6
        orderNoteContainerView.layer.borderColor = UIColor.brownGrey.cgColor
        orderNoteContainerView.layer.borderWidth = 1
        
        orderNote.delegate = self
        orderNote.text = Constants.userOrderNotePlaceholderText
        orderNote.textColor = .lightGray
        orderNote.backgroundColor = .white
        
        self.animationView.frame = self.view.frame
        self.view.addSubview(animationView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(confirmButtonTapped), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.userConfirmOrderObserve), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShoppingCart(isCheckOut: false)
        setUpAgreeTermsButton()
    }
    
    @objc func getTerms() {
        if viewModel.isPaymentSettingsEmpty() {
            getPaymentSettings()
        } else {
            openTermsLink()
        }
    }
    
    private func getPaymentSettings() {
        viewModel.getPaymentSettings(success: {
            self.openTermsLink()
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func openTermsLink() {
        if let url = URL(string: viewModel.getTermsLink()) , url != nil {
            let controller = SFSafariViewController(url: url)
            prompt(controller, animated: true, completion: nil)
            controller.delegate = self
        } else {
            agreeTermsTitleContainer.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func cardViewEditButtonTapped() {
        let shoppingCartVC = SRShoppingCartViewController(viewModel: SRShoppingCartViewModel())
        self.prompt(shoppingCartVC, animated: true, completion: nil)
    }
    
    @IBAction func paymentViewEditButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updatePaymentMethodObserve), object: nil)
    }
    
    @IBAction func billingAddressEditButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateAddressMethodObserve), object: nil)
    }
    
    @IBAction func deliveryAddressEditButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateAddressMethodObserve), object: nil)
    }
    
    
    @objc func confirmButtonTapped() {
            if self.viewModel.isAgreeTermsButtonChecked {
                self.getShoppingCart(isCheckOut: true)
            } else {
                self.isShoppingCartPopUp = false
                let agreementPopUp = PopUpViewViewController(viewModel: self.viewModel.getAgreementCheckPopUpModel())
                agreementPopUp.delegate = self
                self.popUp(agreementPopUp, completion: nil)
            }
    }
    
    private func getShoppingCart(isCheckOut: Bool){
        viewModel.getShoppingCart(success: {
            if isCheckOut {
                if self.viewModel.isInvalidItemsAvailable() {
                    self.isShoppingCartPopUp = true
                    self.showUpdateShoppingCartDialog()
                } else {
                    self.makeOrder()
                }
            } else {
                self.setUpLayout()
            }
            
        }) { (errorViewModel) in
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func makeOrder() {
        if SRNetworkCheckHelper.isConnectedToNetwork(){
            DispatchQueue.main.async {
                if (!self.animationView.isAnimationPlaying) {
                    self.showAnimation()
                    self.delegate?.hideConfirmOrderButton()
                }
            }
            viewModel.setMakeOrderBuyerModel()
            viewModel.makeOrder?.buyer.email = SRAppContext.userEmail
            viewModel.makeOrder?.userId = SRAppContext.userId
            viewModel.makeOrder?.bankAccount = SRSessionManager.shared.orderEvent.bankAccount?.accountToString
            viewModel.makeOrder?.paymentAccount = SRSessionManager.shared.orderEvent.bankAccount
            viewModel.makeOrder?.bankAccountModel = SRSessionManager.shared.orderEvent.bankAccount
            viewModel.makeOrder?.userBillingAdressModel = SRSessionManager.shared.userBillingAddress
            viewModel.makeOrder?.userShippingAdressModel = SRSessionManager.shared.userDeliveryAddress
            viewModel.makeOrder?.billingAddress = SRSessionManager.shared.userBillingAddress?.getOrderAdress()
            viewModel.makeOrder?.billingAddress?.description = SRSessionManager.shared.userBillingAddress?.addressLine
            viewModel.makeOrder?.shippingAddress = SRSessionManager.shared.userDeliveryAddress?.getOrderAdress()
            viewModel.makeOrder?.shippingAddress?.description = SRSessionManager.shared.userDeliveryAddress?.addressLine
            viewModel.makeOrder?.paymentType = SRSessionManager.shared.orderEvent.paymentType
            viewModel.makeOrder?.creditCard = SRSessionManager.shared.orderEvent.orderCard
            if SRSessionManager.shared.makeOrder?.tryAgain == true {
                tryAgainOrder()
            } else {
                sendOrder()
            }
        } else {
            showNoConnectionAlert()
        }
    }
    
    private func showAnimation() {
        self.animationView.isHidden = false
        self.bottomPriceView.isHidden = true
        self.mainContainerView.isHidden = true
        self.mainContainerView.backgroundColor = .white
        animationView.animation = Animation.named("progress_bar",bundle: .shopiroller)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
    
    private func stopAnimation() {
        self.animationView.isHidden = true
        self.animationView.stop()
        self.bottomPriceView.isHidden = false
    }
    
    
    private func tryAgainOrder() {
        viewModel.tryAgainOrder(success: {
            var delay = 0
            let responseTime = Date().timeIntervalSince1970 - self.timeInSeconds
            if (responseTime < 1500) {
                delay = Int(1500 - responseTime)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
                self.stopAnimation()
                NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
            }
            
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            var delay = 0
            let responseTime = Date().timeIntervalSince1970 - self.timeInSeconds
            if (responseTime < 1500) {
                delay = Int(1500 - responseTime)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
                if (SRSessionManager.shared.orderResponseInnerModel?.order?.paymentType != .PayPal) {
                    self.stopAnimation()
                    NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
                }
                
            }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func sendOrder() {
        viewModel.sendOrder(success: {
            SRSessionManager.shared.makeOrder = self.viewModel.makeOrder
            var delay = 0
            let responseTime = Date().timeIntervalSince1970 - self.timeInSeconds
            if (responseTime < 1500) {
                delay = Int(1500 - responseTime)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
                self.stopAnimation()
                NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
            }
            
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            var delay = 0
            let responseTime = Date().timeIntervalSince1970 - self.timeInSeconds
            if (responseTime < 1500) {
                delay = Int(1500 - responseTime)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
                if (SRSessionManager.shared.orderResponseInnerModel?.order?.paymentType != .PayPal) {
                    self.stopAnimation()
                    NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
                }
            }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func showUpdateShoppingCartDialog() {
        let popUpVc = PopUpViewViewController(viewModel: viewModel.getUpdateCardPopUpModel())
        popUpVc.delegate = self
        popUp(popUpVc, completion: nil)
    }
    
    @objc func setUpLayout() {
        self.mainContainerView.isHidden = false
        billingAddressViewDescription.text = SRSessionManager.shared.userBillingAddress?.getSummaryDescriptionArea()
        deliveryAddressCardDescription.text = SRSessionManager.shared.userDeliveryAddress?.getSummaryDescriptionArea()
        shoppingCardViewDescription.text = viewModel.getCardDescription()
        bottomPriceView.setup(model: viewModel.getBottomPriceModel())
        mainContainerView.isHidden = false
        switch SRSessionManager.shared.orderEvent.paymentType {
        case PaymentTypeEnum.PayPal.rawValue:
            paymentCardViewDescription.text = "e_commerce_payment_method_selection_paypal".localized
        case PaymentTypeEnum.PayAtDoor.rawValue:
            paymentCardViewDescription.text = "e_commerce_payment_method_selection_pay_at_door".localized
        case PaymentTypeEnum.Online.rawValue , PaymentTypeEnum.Online3DS.rawValue:
            paymentCardViewDescription.text = viewModel.getCreditCardDescription()
        case PaymentTypeEnum.Transfer.rawValue:
            billingAddressViewTitle.text = Constants.billingAddressCardViewTitle
            deliveryAddressCardTitle.text = Constants.deliveryAddressCardViewTitle
            paymentCardViewDescription.text = viewModel.getTrasnferToBankDescriptonText()
        case PaymentTypeEnum.Stripe.rawValue , PaymentTypeEnum.Stripe3DS.rawValue :
            paymentCardViewDescription.text = "e_commerce_payment_method_selection_stripe".localized
        default:
            break
        }
    }
    
    @IBAction func agreeTermsButtonTapped() {
        viewModel.isAgreeTermsButtonChecked = !viewModel.isAgreeTermsButtonChecked
        setUpAgreeTermsButton()
    }
    
    private func setUpAgreeTermsButton() {
        if viewModel.isAgreeTermsButtonChecked {
            agreeTermsButton.setImage(UIImage(systemName: "checkmark.circle"))
            agreeTermsButton.imageView?.tintColor = .textPrimary
        } else {
            agreeTermsButton.setImage(UIImage(systemName: "circle"))
            agreeTermsButton.imageView?.tintColor = .veryLightPink
        }
    }
}


extension CheckOutInfoViewController : PopUpViewViewControllerDelegate {
    func firstButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController) {
        popUpViewController.dismiss(animated: true, completion: {
            if self.isShoppingCartPopUp {
                let shoppingCartVC = SRShoppingCartViewController(viewModel: SRShoppingCartViewModel())
                self.popUp(shoppingCartVC, completion: nil)
            } else {
                self.viewModel.isAgreeTermsButtonChecked = true
                self.setUpAgreeTermsButton()
            }
        })
    }
    
    func secondButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController) {
        
    }
}

extension CheckOutInfoViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if orderNote.textColor == UIColor.lightGray {
            orderNote.textColor = UIColor.black
            orderNote.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.isOrderNoteChanged = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if orderNote.text != "" && orderNote.textColor == .black {
            viewModel.makeOrder?.userNote = textView.text
        } else {
            orderNote.textColor = UIColor.lightGray
            orderNote.text = Constants.userOrderNotePlaceholderText
        }
    }
    
}

extension CheckOutInfoViewController : SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
