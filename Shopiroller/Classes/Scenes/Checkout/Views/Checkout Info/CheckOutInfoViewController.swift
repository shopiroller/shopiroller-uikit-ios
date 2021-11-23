//
//  CheckOutInfoViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import SafariServices

class CheckOutInfoViewController: BaseViewController<CheckOutInfoViewModel> {
    
    
    private struct Constants {
        static var shoppingCardViewTitle: String { return "checkout-info-shopping-card-view-title".localized }
        static var paymentCardViewTitle: String { return "checkout-info-payment-card-view-title".localized }
        static var billingAddressCardViewTitle: String { return "checkout-info-billing-address-card-view-title".localized }
        static var deliveryAddressCardViewTitle: String { return "checkout-info-delivery-addresss-card-view-title".localized }
        static var confirmOrderButtonTitle: String { return "checkout-info-confirm-order-button-title".localized }
        static var agreeTermsAndConditionsText: String { return "checkout-info-terms-and-conditions-text".localized }
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
    
    private var isAgreeTermsButtonChecked: Bool = false
    
    private var isShoppingCartPopUp : Bool = true
    
    var delegate: CheckOutProgressPageDelegate?
    
    init(viewModel: CheckOutInfoViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutInfoViewController.nibName, bundle: Bundle(for: CheckOutInfoViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        shoppingCardViewContainer.layer.cornerRadius = 6
        shoppingCardViewContainer.backgroundColor = .buttonLight
        shoppingCardViewTitle.text = Constants.shoppingCardViewTitle
        shoppingCardViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        shoppingCardViewDescription.font = UIFont.systemFont(ofSize: 12)
        shoppingCardViewDescription.textColor = .textPCaption
        shoppingCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        shoppingCardViewEditButton.tintColor = .textPCaption
        shoppingCardViewImage.image = .cartIcon
        
        paymentCardViewContainer.layer.cornerRadius = 6
        paymentCardViewContainer.backgroundColor = .buttonLight
        paymentCardViewTitle.text = Constants.paymentCardViewTitle
        paymentCardViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        paymentCardViewDescription.font = UIFont.systemFont(ofSize: 12)
        paymentCardViewDescription.textColor = .textPCaption
        paymentCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        paymentCardViewEditButton.tintColor = .textPCaption
        paymentCardViewImage.image = .paymentIcon
        
        billingAddressCardViewContainer.layer.cornerRadius = 6
        billingAddressCardViewContainer.backgroundColor = .buttonLight
        billingAddressViewTitle.text = Constants.billingAddressCardViewTitle
        billingAddressViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        billingAddressViewDescription.font = UIFont.systemFont(ofSize: 12)
        billingAddressViewDescription.textColor = .textPCaption
        billingAddressCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        billingAddressCardViewEditButton.tintColor = .textPCaption
        billingAddressViewImage.image = .billingAddressIcon
        
        deliveryAddressCardViewContainer.layer.cornerRadius = 6
        deliveryAddressCardViewContainer.backgroundColor = .buttonLight
        deliveryAddressCardTitle.text = Constants.deliveryAddressCardViewTitle
        deliveryAddressCardTitle.font = UIFont.boldSystemFont(ofSize: 14)
        deliveryAddressCardDescription.font = UIFont.systemFont(ofSize: 12)
        deliveryAddressCardDescription.textColor = .textPCaption
        deliveryAddressCardEditButton.setImage(UIImage(systemName: "pencil"))
        deliveryAddressCardEditButton.tintColor = .textPCaption
        deliveryAddressCardImage.image = .deliveryAddressIcon
        
        agreeTermsButton.setImage(UIImage(systemName: "circle"))
        agreeTermsButton.imageView?.tintColor = .veryLightPink
        
        agreeTermsTitle.attributedText = Constants.agreeTermsAndConditionsText.convertHtml()
        agreeTermsTitle.font = UIFont.systemFont(ofSize: 12)
        agreeTermsTitle.textColor = .textPCaption
        let agreeTapGesture = UITapGestureRecognizer(target: self, action: #selector(getTerms))
        agreeTermsTitleContainer.addGestureRecognizer(agreeTapGesture)
        
        orderNoteContainerView.backgroundColor = .buttonLight
        orderNoteContainerView.layer.cornerRadius = 6
        orderNoteContainerView.layer.borderColor = UIColor.brownGrey.cgColor
        orderNoteContainerView.layer.borderWidth = 1
        getShoppingCart(isCheckOut: false)
        orderNote.delegate = self
        orderNote.text = "checkout-info-order-note-text-view-placeholder".localized
        orderNote.textColor = UIColor.lightGray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(confirmButtonTapped), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.userConfirmOrderObserve), object: nil)
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
        }
    }
    
    
    private func openTermsLink() {
        if let url = viewModel.getTermsLink() {
            let controller = SFSafariViewController(url: URL(string: url)!)
            present(controller, animated: true, completion: nil)
            controller.delegate = self
        }
    }
    
    @IBAction func cardViewEditButtonTapped() {
        let shoppingCartVC = ShoppingCartViewController(viewModel: ShoppingCartViewModel())
        shoppingCartVC.modalPresentationStyle = .overFullScreen
        present(shoppingCartVC, animated: true, completion: nil)
    }
    
    @IBAction func paymentViewEditButtonTapped() {
        delegate?.currentPageIndex(currentIndex: 1)
        let checkOutPaymentVC = CheckOutViewController(viewModel: CheckOutViewModel(currentStage: .payment))
        checkOutPaymentVC.modalPresentationStyle = .overFullScreen
        present(checkOutPaymentVC, animated: true, completion: nil)
    }
    
    @IBAction func billingAddressEditButtonTapped() {
        let checkOutBillingAddressVC = CheckOutViewController(viewModel: CheckOutViewModel(currentStage: .address))
        checkOutBillingAddressVC.modalPresentationStyle = .overFullScreen
        present(checkOutBillingAddressVC, animated: true, completion: nil)
    }
    
    @IBAction func deliveryAddressEditButtonTapped() {
        let checkOutDeliveryAddressVC = CheckOutViewController(viewModel: CheckOutViewModel(currentStage: .address))
        checkOutDeliveryAddressVC.modalPresentationStyle = .overFullScreen
        present(checkOutDeliveryAddressVC, animated: true, completion: nil)
    }
    
    
    @objc func confirmButtonTapped() {
        if isAgreeTermsButtonChecked {
            getShoppingCart(isCheckOut: true)
        } else {
            isShoppingCartPopUp = false
            let agreementPopUp = PopUpViewViewController(viewModel: viewModel.getAgreementCheckPopUpModel())
            agreementPopUp.delegate = self
            popUp(agreementPopUp, completion: nil)
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
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func makeOrder() {
        let names : [String] = SRSessionManager.shared.userBillingAddress?.contact?.nameSurname?.components(separatedBy: " ") ?? []
        if names.count != 0 {
            viewModel.makeOrder?.buyer?.name = names[0]
            viewModel.makeOrder?.buyer?.surname = ""
            if names.count > 1 {
                for i in 1..<(names.count){
                    if i == 1 {
                        viewModel.makeOrder?.buyer?.surname = names[0]
                    }else {
                        viewModel.makeOrder?.buyer?.surname? += " " + names[i]
                    }
                }
            }
        }
        viewModel.makeOrder?.buyer?.email = "gorkemgur@mobiroller.com"
        viewModel.makeOrder?.userId = SRAppConstants.Query.Values.userId
        viewModel.makeOrder?.bankAccount = SRSessionManager.shared.orderEvent.bankAccount?.accountToString
        viewModel.makeOrder?.paymentAccount = SRSessionManager.shared.orderEvent.bankAccount
        viewModel.makeOrder?.bankAccountModel = SRSessionManager.shared.orderEvent.bankAccount
        viewModel.makeOrder?.userBillingAdressModel = SRSessionManager.shared.userBillingAddress
        viewModel.makeOrder?.userShippingAdressModel = SRSessionManager.shared.userDeliveryAddress
        viewModel.makeOrder?.paymentType = SRSessionManager.shared.orderEvent.paymentType
        if viewModel.makeOrder?.tryAgain == true {
            tryAgainOrder()
        } else {
            sendOrder()
        }
    }
    
    private func tryAgainOrder() {
        viewModel.tryAgainOrder(success: {
            NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func sendOrder() {
        viewModel.sendOrder(success: {
            NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func showUpdateShoppingCartDialog() {
        let popUpVc = PopUpViewViewController(viewModel: viewModel.getUpdateCardPopUpModel())
        popUpVc.delegate = self
        popUp(popUpVc, completion: nil)
    }
    
    private func setUpLayout() {
        billingAddressViewDescription.text = SRSessionManager.shared.userBillingAddress?.getSummaryDescriptionArea()
        deliveryAddressCardDescription.text = SRSessionManager.shared.userDeliveryAddress?.getSummaryDescriptionArea()
        shoppingCardViewDescription.text = viewModel.getCardDescription()
        bottomPriceView.setup(model: viewModel.getBottomPriceModel())
        mainContainerView.isHidden = false
        switch SRSessionManager.shared.orderEvent.paymentType {
        case PaymentTypeEnum.PayPal.rawValue:
            paymentCardViewDescription.text = "list-pop-up-paypal-text".localized
        case PaymentTypeEnum.PayAtDoor.rawValue:
            paymentCardViewDescription.text = "list-pop-up-pay-at-the-door-text".localized
        case PaymentTypeEnum.Online.rawValue , PaymentTypeEnum.Online3DS.rawValue:
            paymentCardViewDescription.text = viewModel.getCreditCardDescription()
        case PaymentTypeEnum.Transfer.rawValue:
            billingAddressViewTitle.text = "checkout-info-billing-address-card-view-title".localized
            deliveryAddressCardTitle.text = "checkout-info-delivery-addresss-card-view-title".localized
            paymentCardViewDescription.text = viewModel.getTrasnferToBankDescriptonText()
        default:
            break
        }
    }
    
    @IBAction func agreeTermsButtonTapped() {
        isAgreeTermsButtonChecked = !isAgreeTermsButtonChecked
        setUpAgreeTermsButton()
    }
    
    private func setUpAgreeTermsButton() {
        if isAgreeTermsButtonChecked {
            agreeTermsButton.setImage(UIImage(systemName: "checkmark.circle"))
            agreeTermsButton.imageView?.tintColor = .textPrimary
        }else {
            agreeTermsButton.setImage(UIImage(systemName: "circle"))
            agreeTermsButton.imageView?.tintColor = .veryLightPink
        }
    }
}


extension CheckOutInfoViewController : PopUpViewViewControllerDelegate {
    func firstButtonClicked(_ sender: Any) {
        if isShoppingCartPopUp {
            let shoppingCartVC = ShoppingCartViewController(viewModel: ShoppingCartViewModel())
            popUp(shoppingCartVC, completion: nil)
        } else {
            self.isAgreeTermsButtonChecked = true
            self.setUpAgreeTermsButton()
        }
    }
    
    func secondButtonClicked(_ sender: Any) {
        
    }
}

extension CheckOutInfoViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if orderNote.textColor == UIColor.lightGray {
            viewModel.makeOrder?.userNote = textView.text
            orderNote.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if orderNote.text.isEmpty {
            orderNote.text = "checkout-info-order-note-text-view-placeholder".localized
            orderNote.textColor = UIColor.lightGray
        }
    }
}

extension CheckOutInfoViewController : SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
