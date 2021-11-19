//
//  CheckOutInfoViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

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
    @IBOutlet private weak var confirmOrderButton: UIButton!
    
    private var isAgreeTermsButtonChecked: Bool = false
    
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
        shoppingCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        shoppingCardViewEditButton.tintColor = .textPCaption
        shoppingCardViewImage.image = .cartIcon
        
        paymentCardViewContainer.layer.cornerRadius = 6
        paymentCardViewContainer.backgroundColor = .buttonLight
        paymentCardViewTitle.text = Constants.paymentCardViewTitle
        paymentCardViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        paymentCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        paymentCardViewEditButton.tintColor = .textPCaption
        paymentCardViewImage.image = .paymentIcon
        
        billingAddressCardViewContainer.layer.cornerRadius = 6
        billingAddressCardViewContainer.backgroundColor = .buttonLight
        billingAddressViewTitle.text = Constants.billingAddressCardViewTitle
        billingAddressViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        billingAddressCardViewEditButton.setImage(UIImage(systemName: "pencil"))
        billingAddressCardViewEditButton.tintColor = .textPCaption
        billingAddressViewImage.image = .billingAddressIcon
        
        deliveryAddressCardViewContainer.layer.cornerRadius = 6
        deliveryAddressCardViewContainer.backgroundColor = .buttonLight
        deliveryAddressCardTitle.text = Constants.deliveryAddressCardViewTitle
        deliveryAddressCardTitle.font = UIFont.boldSystemFont(ofSize: 14)
        deliveryAddressCardEditButton.setImage(UIImage(systemName: "pencil"))
        deliveryAddressCardEditButton.tintColor = .textPCaption
        deliveryAddressCardImage.image = .deliveryAddressIcon
        
        
        agreeTermsButton.setImage(UIImage(systemName: "circle"))
        agreeTermsButton.imageView?.tintColor = .veryLightPink
        
        agreeTermsTitle.text = Constants.agreeTermsAndConditionsText
        agreeTermsTitle.font = UIFont.systemFont(ofSize: 12)
        agreeTermsTitle.textColor = .textPCaption
        
        orderNoteContainerView.backgroundColor = .buttonLight
        orderNoteContainerView.layer.cornerRadius = 6
        orderNoteContainerView.layer.borderColor = UIColor.brownGrey.cgColor
        orderNoteContainerView.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getShoppingCart(isCheckOut: false)
        print(SRSessionManager.shared.userDeliveryAddress)
    }
    
    private func getShoppingCart(isCheckOut: Bool){
        viewModel.getShoppingCart(success: {
            self.setUpLayout()
            if isCheckOut {
                self.showUpdateShoppingCartDialog()
            } else {
                self.makeOrder()
            }
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func makeOrder() {
        
    }
    
    private func showUpdateShoppingCartDialog() {
        let popUpVc = PopUpViewViewController(viewModel: viewModel.getUpdateCardPopUpModel())
        popUp(popUpVc, completion: nil)
    }

    private func setUpLayout() {
        mainContainerView.isHidden = false
        switch SRSessionManager.shared.orderEvent.paymentType {
        case PaymentTypeEnum.PayPal.rawValue:
            paymentCardViewTitle.text = "list-pop-up-paypal-text".localized
        case PaymentTypeEnum.PayAtDoor.rawValue:
            paymentCardViewTitle.text = "list-pop-up-bank-transfer-text".localized
        case PaymentTypeEnum.Online.rawValue , PaymentTypeEnum.Online3DS.rawValue:
            paymentCardViewTitle.text = "list-pop-up-credit-cart-text".localized
        case PaymentTypeEnum.Transfer.rawValue:
            billingAddressViewTitle.text = "checkout-info-billing-address-card-view-title".localized
            deliveryAddressCardTitle.text = "checkout-info-delivery-address-card-view-title"
            paymentCardViewTitle.text = "list-pop-up-pay-at-the-door-text".localized
        default:
            break
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if orderNote.textColor == UIColor.lightGray {
            orderNote.text = nil
            orderNote.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if orderNote.text.isEmpty {
            orderNote.text = "checkout-info-order-note-text-view-placeholder".localized
            orderNote.textColor = UIColor.lightGray
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
        let shoppingCartVC = ShoppingCartViewController(viewModel: ShoppingCartViewModel())
        popUp(shoppingCartVC, completion: nil)
    }
    
    func secondButtonClicked(_ sender: Any) {
        
    }
}
