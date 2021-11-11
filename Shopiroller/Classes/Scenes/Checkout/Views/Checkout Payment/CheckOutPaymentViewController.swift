//
//  CheckOutPaymentViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

class CheckOutPaymentViewController: BaseViewController<CheckOutPaymentViewModel> {
    
    private struct Constants {
        
        static var selectPaymentMethodText : String { return "checkout-payment-select-payment-method-text".localized }
        static var selectedPaymentMethodCreditCart : String { return "checkout-payment-selected-payment-method-credit-cart-placeholder".localized }
        static var selectedPaymentMethodBankTransfer : String { return "checkout-payment-selected-payment-method-transfer-bank-placeholder".localized }
        static var selectedPaymentMethodPayAtTheDoor : String { return "checkout-payment-selected-payment-method-pay-at-the-door-placeholder".localized }
        static var creditCartHolderNamePlaceholder : String { return "checkout-payment-credit-card-holder-placeholder".localized }
        static var creditCartNumberPlaceholder : String { return "checkout-payment-credit-card-number-placeholder".localized }
        static var creditCartExpireDatePlaceholder : String { return "checkout-payment-credit-card-expire-date-placeholer".localized }
        static var creditCartCvvPlaceholder : String { return "checkout-payment-credit-card-cvv-placeholder".localized }
        
        static var payAtTheDoorDescription: String {
            return "checkout-payment-pay-at-the-door-description".localized
        }
    }
    
    
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var paymentEmptyView: EmptyView!
    @IBOutlet private weak var selectPaymentMethodView: UIView!
    @IBOutlet private weak var selectMethodTitle: UILabel!
    @IBOutlet private weak var selectedMethodTitle: UILabel!
    @IBOutlet private weak var selectMethodRightArrow: UIImageView!
    @IBOutlet private weak var methodTitleView: UIView!
    @IBOutlet private weak var selectedMethodViewTitle: UILabel!
    @IBOutlet private weak var titleUnderLineView: UIView!
    @IBOutlet private weak var creditCartContainer: UIView!
    @IBOutlet private weak var creditCartHolderNameTextField: UITextField!
    @IBOutlet private weak var creditCartNumberTextField: UITextField!
    @IBOutlet private weak var creditCartImageView: UIImageView!
    @IBOutlet private weak var creditCartExpireDateTextField: UITextField!
    @IBOutlet private weak var creditCartCvvTextField: UITextField!
    @IBOutlet private weak var bankTransferContainer: UIView!
    @IBOutlet private weak var bankTransferTableView: UITableView!
    @IBOutlet private weak var payAtTheDoorDescription: UILabel!
    @IBOutlet private weak var payAtTheDoorContainer: UIView!
    
    var delegate : CheckOutProgressPageDelegate?
    
    init(viewModel: CheckOutPaymentViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutPaymentViewController.nibName, bundle: Bundle(for:  CheckOutPaymentViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        selectPaymentMethodView.backgroundColor = .buttonLight.withAlphaComponent(0.77)
        selectPaymentMethodView.layer.cornerRadius = 6
        selectMethodTitle.textColor = .textSecondary
        selectMethodTitle.font = UIFont.systemFont(ofSize: 13)
        selectMethodTitle.text = Constants.selectPaymentMethodText
        
        titleUnderLineView.backgroundColor = .veryLightBlue
        
        selectMethodRightArrow.image = UIImage(systemName: "chevron.right")
        selectMethodRightArrow.tintColor = .textPCaption
        
        selectedMethodTitle.textColor = .textPCaption
        selectedMethodTitle.font = UIFont.systemFont(ofSize: 12)
        
        selectedMethodViewTitle.textColor = .textPCaption
        selectedMethodViewTitle.font = UIFont.systemFont(ofSize: 12)
        
        creditCartHolderNameTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartHolderNameTextField.layer.cornerRadius = 6
        creditCartHolderNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartHolderNameTextField.frame.height))
        creditCartHolderNameTextField.leftViewMode = .always

        creditCartNumberTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartNumberTextField.layer.cornerRadius = 6
        creditCartNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartNumberTextField.frame.height))
        creditCartNumberTextField.leftViewMode = .always
        
        creditCartExpireDateTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartExpireDateTextField.layer.cornerRadius = 6
        creditCartExpireDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartExpireDateTextField.frame.height))
        creditCartExpireDateTextField.leftViewMode = .always
        
        creditCartCvvTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartCvvTextField.layer.cornerRadius = 6
        creditCartCvvTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartCvvTextField.frame.height))
        creditCartCvvTextField.leftViewMode = .always
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPaymentSettings()
    }
    
    private func getPaymentSettings() {
        viewModel.getPaymentSettings(success: {
            self.configureEmptyView()
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func configureEmptyView() {
        if viewModel.arePaymentSettingsEmpty() {
            contentContainerView.isHidden = true
            paymentEmptyView.isHidden = false
            paymentEmptyView.setup(model: viewModel.getEmptyViewModel())
            delegate?.isHidingNextButton(hide: true)
        } else {
            delegate?.isHidingNextButton(hide: false)
            configureView()
        }
    }
    
    private func configureView() {
        switch viewModel.getDefaultPaymentMethod() {
        case .Transfer:
            bankTransferContainer.isHidden = false
            payAtTheDoorContainer.isHidden = true
            creditCartContainer.isHidden = true
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodBankTransfer.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodBankTransfer
            
        case .Online:
            bankTransferContainer.isHidden = true
            payAtTheDoorContainer.isHidden = true
            creditCartContainer.isHidden = false
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodCreditCart.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodCreditCart

        case .Online3DS:
            bankTransferContainer.isHidden = true
            creditCartContainer.isHidden = false
            payAtTheDoorContainer.isHidden = true
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodCreditCart.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodCreditCart

        case .PayPal:
            bankTransferContainer.isHidden = true
            creditCartContainer.isHidden = true
            payAtTheDoorContainer.isHidden = true
            selectedMethodViewTitle.text = PaymentTypeEnum.PayPal.rawValue.uppercased().localized
        case .PayAtDoor:
            bankTransferContainer.isHidden = true
            creditCartContainer.isHidden = true
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodPayAtTheDoor.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodPayAtTheDoor
            payAtTheDoorDescription.font = UIFont.systemFont(ofSize: 14)
            payAtTheDoorDescription.textColor = .textPCaption
            payAtTheDoorDescription.text = Constants.payAtTheDoorDescription
        case .none:
            break
        }
    }

    
}
