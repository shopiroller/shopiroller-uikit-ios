//
//  OrderDetailViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class SROrderDetailViewController: BaseViewController<SROrderDetailViewModel> {
    
    private struct Constants {
        static var orderInfoTitle: String { return "e_commerce_order_details_information_title".localized }
        static var paymentInfoTitle: String { return "e_commerce_order_details_payment_information_title".localized }
        static var addressInfoTitle: String { return "e_commerce_order_details_address_information_title".localized }
        static var productsInfoTitle: String { return "e_commerce_order_details_product_title".localized }
        static var bankAccountReceiverText: String { return "e_commerce_order_details_bank_receiver".localized }
        static var bankAccount: String { return "e_commerce_order_details_bank_account".localized }
        static var bankAccountIban: String { return "e_commerce_order_details_bank_iban".localized }
        static var bankAccountIbanCopiedText: String { return "e_commerce_order_details_bank_copy_toast_message".localized }
        static var orderNoteText: String { return "e_commerce_order_details_user_note_sub_title".localized  }
    }
    
    @IBOutlet weak var bottomPriceView: BottomPriceView!
    
    @IBOutlet private weak var bankAccountName: UILabel!
    @IBOutlet private weak var bankAccountUserName: UILabel!
    @IBOutlet private weak var bankAccountNumber: UILabel!
    @IBOutlet private weak var bankAccountIban: UILabel!
    @IBOutlet private weak var bankTransferContainerView: UIView!
    
    @IBOutlet private weak var creditCartContainerView: UIView!
    @IBOutlet private weak var creditCartNumberLabel: UILabel!
    
    @IBOutlet private weak var orderDetailTitleLabel: UILabel!
    @IBOutlet private weak var orderDetailId: UILabel!
    @IBOutlet private weak var orderDetailPaymentStatus: UILabel!
    @IBOutlet private weak var orderDetailDate: UILabel!
    @IBOutlet private weak var orderDetailStatusImage: UIImageView!
    @IBOutlet private weak var orderNote: UILabel!
    
    @IBOutlet private weak var cargoTrackingTitleLabel: UILabel!
    @IBOutlet private weak var cargoTrackingName: UILabel!
    @IBOutlet private weak var cargoTrackingId: UILabel!
    
    @IBOutlet private weak var paymentTitleLabel: UILabel!
    @IBOutlet private weak var paymentTypeDescription: UILabel!
    
    @IBOutlet private weak var addressDataStackView: UIStackView!
    @IBOutlet private weak var productsDataStackView: UIStackView!
    
    @IBOutlet private weak var cargoSeparator: UIView!
    @IBOutlet private weak var cargoStackView: UIStackView!
    @IBOutlet private weak var paymentSeparator: UIView!
    @IBOutlet private weak var paymentStackView: UIStackView!
    @IBOutlet private weak var addressSeparator: UIView!
    @IBOutlet private weak var addressDetailTitleLabel: UILabel!
    @IBOutlet private weak var productsSeparator: UIView!
    @IBOutlet private weak var productsTitleLabel: UILabel!
    @IBOutlet private weak var productsStackView: UIStackView!
    
    @IBOutlet private weak var addressHeight: NSLayoutConstraint!
    @IBOutlet private weak var productsHeight: NSLayoutConstraint!

    
    
    init(viewModel: SROrderDetailViewModel) {
        super.init("e_commerce_order_details_page_title".localized, viewModel: viewModel, nibName: SROrderDetailViewController.nibName, bundle: Bundle(for: SROrderDetailViewController.self))
    }
    
    override func setup() {
        super.setup()
        getCount()
        orderDetailStatusImage.image = viewModel.getStatusImage()
        
        orderDetailTitleLabel.textColor = .textPrimary
        orderDetailTitleLabel.text = Constants.orderInfoTitle
        orderDetailTitleLabel.font = .bold18
        
        let ibanTextTapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickIbanText))
        bankAccountIban.isUserInteractionEnabled = true
        bankAccountIban.addGestureRecognizer(ibanTextTapGesture)
        
        bankAccountName.textColor = .textPCaption
        bankAccountName.font = .regular12
        bankAccountIban.textColor = .textPCaption
        bankAccountIban.font = .regular12
        bankAccountNumber.textColor = .textPCaption
        bankAccountNumber.font = .regular12
        bankAccountUserName.textColor = .textPCaption
        bankAccountUserName.font = .regular12
        
        creditCartNumberLabel.textColor = .textPCaption
        creditCartNumberLabel.font = .regular12
        
        cargoTrackingTitleLabel.textColor = .textPrimary
        cargoTrackingTitleLabel.font = .bold18
        
        paymentTitleLabel.textColor = .textPrimary
        paymentTitleLabel.text = Constants.paymentInfoTitle
        paymentTitleLabel.font = .bold18
        
        addressDetailTitleLabel.textColor = .textPrimary
        addressDetailTitleLabel.text = Constants.addressInfoTitle
        addressDetailTitleLabel.font = .bold18
        
        productsTitleLabel.textColor = .textPrimary
        productsTitleLabel.text = Constants.productsInfoTitle
        productsTitleLabel.font = .bold18
        
        orderDetailId.textColor = .textPCaption
        orderDetailId.font = .regular12
        
        orderDetailPaymentStatus.textColor = .textPCaption
        orderDetailPaymentStatus.font = .regular12
        
        orderDetailDate.textColor = .textPCaption
        orderDetailDate.font = .regular12
        
        orderNote.textColor = .textPCaption
        orderNote.font = .regular12
        
        orderDetailId.text = viewModel.getOrderCode()
        orderDetailPaymentStatus.text = viewModel.getCurrentStatus()
        orderDetailDate.text = viewModel.getCreatedDate()
        
        if let userNote = viewModel.getUserNote() , userNote != "" {
            orderNote.text = String(format: Constants.orderNoteText, userNote)
        } else {
            orderNote.isHidden = true
        }
        
        if (viewModel.isCargoTrackingAvailable()) {
            cargoTrackingId.textColor = .textPCaption
            cargoTrackingId.font = .regular12
            cargoTrackingName.textColor = .textPCaption
            cargoTrackingName.font = .regular12
            cargoTrackingId.text = viewModel.getShippingTrackingCode()
            cargoTrackingName.text = viewModel.getShippingTrackingCompany()
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(SROrderDetailViewController.onClickCargoText))
            cargoTrackingId.addGestureRecognizer(tap)
            
        } else {
            cargoSeparator.isHidden = true
            cargoStackView.isHidden = true
        }
        
        if(viewModel.isPaymentTypeAvailable()) {
            paymentTypeDescription.font = .regular12
            paymentTypeDescription.textColor = .textPCaption
            paymentTypeDescription.text = viewModel.getPaymentMethodTitle()
            setPaymentView()
        } else {
            paymentSeparator.isHidden = true
            paymentStackView.isHidden = true
        }
        
        bottomPriceView.setup(model: viewModel.getBottomPriceModel())
    
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        updateNavigationBar(isBackButtonActive: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var itemCount = 0
        if let list = self.viewModel.getProductList() {
            for item in list {
                itemCount += 1
                let orderDetailView = OrderDetailProductView()
                orderDetailView.configure(model: item, isLast: itemCount == list.count)
                productsDataStackView.addArrangedSubview(orderDetailView)
                NSLayoutConstraint.activate([
                    orderDetailView.heightAnchor.constraint(equalToConstant: 75),
                ])
                productsHeight.constant = self.productsHeight.constant + 75
            }
        }
        
        for address in viewModel.getAddressList() {
            let addressView = AddressView()
            addressView.configure(model: address)
            addressDataStackView.addArrangedSubview(addressView)
            NSLayoutConstraint.activate([
                addressView.heightAnchor.constraint(equalToConstant: 106),
            ])
            addressHeight.constant = addressHeight.constant + 121
        }
    }
    
    private func setPaymentView() {
        switch viewModel.getPaymentType() {
        case .Online3DS , .Online:
            creditCartContainerView.isHidden = false
            creditCartNumberLabel.text = viewModel.getCreditCartNumber()
        case .Transfer:
            bankTransferContainerView.isHidden = false
            bankAccountIban.attributedText = ECommerceUtil.getBoldNormal(
                Constants.bankAccountIban,
                viewModel.getBankAccountIban() ?? "")
            bankAccountName.text = viewModel.getBankName()
            bankAccountUserName.attributedText = ECommerceUtil.getBoldNormal(
                Constants.bankAccountReceiverText,
                viewModel.getBankAccountHolderNameSurname() ?? "")
            bankAccountNumber.attributedText = ECommerceUtil.getBoldNormal(
                Constants.bankAccount,
                viewModel.getBankAccountNumber() ?? "")
        default:
            break
        }
    }
    
    
    private func getCount() {
        viewModel.getShoppingCartCount(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] _ in
            guard let self = self else { return }
        }
    }
    
    @objc
    func onClickCargoText(sender:UITapGestureRecognizer) {
        UIPasteboard.general.string = viewModel.getShippingTrackingCode()
    }
    
    @objc
    func onClickIbanText(sender:UITapGestureRecognizer) {
        UIPasteboard.general.string = viewModel.getBankAccountIban()
        var style = ToastStyle()
        style.backgroundColor = .textPrimary.withAlphaComponent(0.7)
        style.messageColor = .white
        style.messageFont = .regular12
        self.view.makeToast(
            Constants.bankAccountIbanCopiedText,
            position: ToastPosition.maxQuantity,
            style: style)
    }
    
}

