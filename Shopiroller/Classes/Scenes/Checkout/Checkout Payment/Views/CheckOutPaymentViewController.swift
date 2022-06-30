//
//  CheckOutPaymentViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import InputMask

class CheckOutPaymentViewController: BaseViewController<CheckOutPaymentViewModel> {
    
    private struct Constants {
        
        static var selectPaymentMethodText : String { return "e_commerce_payment_method_selection_button_title".localized }
        static var selectedPaymentMethodCreditCart : String { return "e_commerce_payment_method_selection_credit_card".localized }
        static var selectedPaymentMethodBankTransfer : String { return "e_commerce_payment_method_selection_transfer".localized}
        static var selectedPaymentMethodPayAtTheDoor : String { return "e_commerce_payment_method_selection_pay_at_door".localized }
        static var creditCartHolderNamePlaceholder : String { return "e_commerce_payment_credit_card_name".localized }
        static var creditCartNumberPlaceholder : String { return "e_commerce_payment_credit_card_number".localized }
        static var creditCartExpireDatePlaceholder : String { return "e_commerce_payment_credit_card_expire_date".localized }
        static var creditCartCvvPlaceholder : String { return "e_commerce_payment_credit_card_security_code".localized }
        static var payWithStripePaypalDescription: String { return "e_commerce_payment_method_selection_description_text".localized }
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
    @IBOutlet private weak var stripeAndPaypalContainer: UIView!
    @IBOutlet private weak var stripeAndPaypalImage: UIImageView!
    @IBOutlet private weak var stripeAndPaypalDescriptionLabel: UILabel!
    
    var delegate : CheckOutProgressPageDelegate?
    var creditCardNumberListener: MaskedTextFieldDelegate!
    var creditCardExpireDateListener: MaskedTextFieldDelegate!
    var creditCardCvvListener: MaskedTextFieldDelegate!
    
    private var isValid: Bool = false
    
    
    init(viewModel: CheckOutPaymentViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutPaymentViewController.nibName, bundle: Bundle(for:  CheckOutPaymentViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        creditCardNumberListener = MaskedTextFieldDelegate()
        creditCardExpireDateListener = MaskedTextFieldDelegate()
        creditCardCvvListener = MaskedTextFieldDelegate()
        
        selectPaymentMethodView.backgroundColor = .buttonLight.withAlphaComponent(0.77)
        selectPaymentMethodView.layer.cornerRadius = 6
        selectMethodTitle.textColor = .textSecondary
        selectMethodTitle.font = .medium14
        selectMethodTitle.text = Constants.selectPaymentMethodText
        
        titleUnderLineView.backgroundColor = .veryLightBlue
        
        selectMethodRightArrow.image = UIImage(systemName: "chevron.right")
        selectMethodRightArrow.tintColor = .textPCaption
        
        selectedMethodTitle.textColor = .textPCaption
        selectedMethodTitle.font = .regular12
        
        selectedMethodViewTitle.textColor = .textPCaption
        selectedMethodViewTitle.font = .regular12
        
        creditCartHolderNameTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartHolderNameTextField.layer.cornerRadius = 6
        creditCartHolderNameTextField.delegate = self
        creditCartHolderNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartHolderNameTextField.frame.height))
        creditCartHolderNameTextField.leftViewMode = .always
        creditCartHolderNameTextField.placeholder = Constants.creditCartHolderNamePlaceholder
        creditCartHolderNameTextField.addNextAction(target: self, selector: #selector(nextActionCreditCartHolderNameTextField))

        creditCartNumberTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartNumberTextField.layer.cornerRadius = 6
        creditCartNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartNumberTextField.frame.height))
        creditCartNumberTextField.delegate = creditCardNumberListener
        creditCartNumberTextField.leftViewMode = .always
        creditCartNumberTextField.textContentType = .creditCardNumber
        creditCartNumberTextField.keyboardType = .numberPad
        creditCardNumberListener.delegate = self
        creditCardNumberListener.primaryMaskFormat =
                     "[0000] [0000] [0000] [0000]"
        creditCardNumberListener.affinityCalculationStrategy = .prefix
        creditCartNumberTextField.placeholder = Constants.creditCartNumberPlaceholder
        creditCartNumberTextField.addNextAction(target: self, selector: #selector(nextActionCreditCartNumberTextField))
        
        creditCartExpireDateTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartExpireDateTextField.layer.cornerRadius = 6
        creditCartExpireDateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartExpireDateTextField.frame.height))
        creditCartExpireDateTextField.delegate = creditCardExpireDateListener
        creditCartExpireDateTextField.leftViewMode = .always
        creditCartExpireDateTextField.keyboardType = .numberPad
        creditCardExpireDateListener.delegate = self
        creditCardExpireDateListener.primaryMaskFormat =
            "[00]{/}[00]"
        creditCardExpireDateListener.affinityCalculationStrategy = .prefix
        creditCartExpireDateTextField.placeholder = Constants.creditCartExpireDatePlaceholder
        creditCartExpireDateTextField.addNextAction(target: self, selector: #selector(nextActionCreditCartExpireDateTextField))
        
        
        creditCartCvvTextField.backgroundColor = .buttonLight.withAlphaComponent(0.7)
        creditCartCvvTextField.layer.cornerRadius = 6
        creditCartCvvTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: creditCartCvvTextField.frame.height))
        creditCartCvvTextField.delegate = creditCardCvvListener
        creditCartCvvTextField.leftViewMode = .always
        creditCartCvvTextField.keyboardType = .numberPad
        creditCardCvvListener.delegate = self
        creditCardCvvListener.primaryMaskFormat = "[000]"
        creditCardCvvListener.affinityCalculationStrategy = .prefix
        creditCartCvvTextField.placeholder = Constants.creditCartCvvPlaceholder
        creditCartCvvTextField.addCustomTextAction(title: "e_commerce_general_keyboard_done_action_text".localized, target: self, selector: #selector(toolbarDoneButtonClicked))
        
        stripeAndPaypalImage.image = .stripeAndPaypalIcon
        
        
        
        let addressSelectTapGesture = UITapGestureRecognizer(target: self, action: #selector(openPaymentList))
        selectPaymentMethodView.isUserInteractionEnabled = true
        selectPaymentMethodView.addGestureRecognizer(addressSelectTapGesture)
        
    }
    
    @objc func nextActionCreditCartHolderNameTextField() {
        _ = textFieldShouldReturn(creditCartHolderNameTextField)
    }
    
    @objc func nextActionCreditCartNumberTextField() {
        _ = textFieldShouldReturn(creditCartNumberTextField)
    }
    
    @objc func nextActionCreditCartExpireDateTextField() {
        _ = textFieldShouldReturn(creditCartExpireDateTextField)
    }
    
    @objc func toolbarDoneButtonClicked() {
        _ = textFieldShouldReturn(creditCartCvvTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPaymentSettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultAddresses()
    }
    
    private func setDefaultAddresses() {
        viewModel.setDefaultShippingAddress(success: {
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
        viewModel.setDefaultBillingAddress(success: {
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func getPaymentSettings() {
        viewModel.getPaymentSettings(success: {
            self.configureEmptyView()
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func configureEmptyView() {
        if viewModel.arePaymentSettingsEmpty() {
            contentContainerView.isHidden = true
            paymentEmptyView.isHidden = false
            paymentEmptyView.setup(model: viewModel.getEmptyViewModel())
            delegate?.isHidingNextButton(hide: true)
        } else {
            contentContainerView.isHidden = false
            paymentEmptyView.isHidden = true
            delegate?.isHidingNextButton(hide: false)
            configureView()
            checkIsValid()
        }
    }
    
    @IBAction func textFieldEditingChanged(_ textField: UITextField) {
        switch textField {
        case creditCartHolderNameTextField:
            viewModel.creditCardHolder = textField.text
        default:
            break
        }
    }
    
    
    private func configureView() {
        switch viewModel.getDefaultPaymentMethod() {
        case .Transfer:
            bankTransferContainer.isHidden = false
            bankTransferTableView.register(cellClass: BankTransferTableViewCell.self)
            bankTransferTableView.delegate = self
            bankTransferTableView.dataSource = self
            bankTransferTableView.reloadData()
            payAtTheDoorContainer.isHidden = true
            creditCartContainer.isHidden = true
            stripeAndPaypalContainer.isHidden = true
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodBankTransfer.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodBankTransfer
        case .Online , .Online3DS:
            bankTransferContainer.isHidden = true
            payAtTheDoorContainer.isHidden = true
            creditCartContainer.isHidden = false
            stripeAndPaypalContainer.isHidden = true
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodCreditCart.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodCreditCart
        case .PayPal:
            bankTransferContainer.isHidden = true
            creditCartContainer.isHidden = true
            payAtTheDoorContainer.isHidden = true
            stripeAndPaypalContainer.isHidden = true
            selectedMethodViewTitle.text = PaymentTypeEnum.PayPal.rawValue.uppercased()
            selectedMethodTitle.text = PaymentTypeEnum.PayPal.rawValue.uppercased()
            stripeAndPaypalContainer.isHidden = false
            stripeAndPaypalDescriptionLabel.font = .regular14
            stripeAndPaypalDescriptionLabel.textColor = .textPCaption
            stripeAndPaypalDescriptionLabel.text = String(format: Constants.payWithStripePaypalDescription, PaymentTypeEnum.PayPal.rawValue)
        case .PayAtDoor:
            bankTransferContainer.isHidden = true
            creditCartContainer.isHidden = true
            payAtTheDoorContainer.isHidden = false
            stripeAndPaypalContainer.isHidden = true
            selectedMethodViewTitle.text = Constants.selectedPaymentMethodPayAtTheDoor.uppercased()
            selectedMethodTitle.text = Constants.selectedPaymentMethodPayAtTheDoor
            payAtTheDoorDescription.font = .regular14
            payAtTheDoorDescription.textColor = .textPCaption
            payAtTheDoorDescription.text = viewModel.getPaymentDescription()
        case .Stripe , .Stripe3DS:
            bankTransferContainer.isHidden = true
            creditCartContainer.isHidden = true
            payAtTheDoorContainer.isHidden = true
            selectedMethodViewTitle.text = PaymentTypeEnum.Stripe.rawValue.uppercased()
            selectedMethodTitle.text = PaymentTypeEnum.Stripe.rawValue.uppercased()
            stripeAndPaypalContainer.isHidden = false
            stripeAndPaypalDescriptionLabel.font = .regular14
            stripeAndPaypalDescriptionLabel.textColor = .textPCaption
            stripeAndPaypalDescriptionLabel.text = String(format: Constants.payWithStripePaypalDescription, PaymentTypeEnum.Stripe.rawValue)
        case .none:
            break
        case .some(.Other):
            break
        }
    }
    
    private func checkIsValid() {
        isValid = (viewModel.getDefaultPaymentMethod() == .PayAtDoor || viewModel.getDefaultPaymentMethod() == .Online || viewModel.getDefaultPaymentMethod() == .Online3DS || viewModel.getDefaultPaymentMethod() == .Stripe  || viewModel.getDefaultPaymentMethod() == .Stripe3DS || viewModel.getDefaultPaymentMethod() == .PayPal || (viewModel.getDefaultPaymentMethod() == .Transfer && viewModel.paymentType != nil))
        if isValid == true {
            SRSessionManager.shared.paymentSettings = viewModel.getPaymentSettings()
            self.delegate?.isEnabledNextButton(enabled: true)
            switch viewModel.getDefaultPaymentMethod() {
            case .PayPal:
                SRSessionManager.shared.orderEvent.paymentType = PaymentTypeEnum.PayPal.rawValue
                self.delegate?.isEnabledNextButton(enabled: true)
            case .Transfer:
                setBankTransferUI()
                SRSessionManager.shared.orderEvent.paymentType = PaymentTypeEnum.Transfer.rawValue
            case .Online3DS, .Online:
                validateCreditCardFields(showAlert: false)
                if viewModel.getDefaultPaymentMethod() == .Online {
                    SRSessionManager.shared.orderEvent.paymentType = PaymentTypeEnum.Online.rawValue
                } else {
                    SRSessionManager.shared.orderEvent.paymentType = PaymentTypeEnum.Online3DS.rawValue
                }
            case .PayAtDoor:
                SRSessionManager.shared.orderEvent.paymentType = PaymentTypeEnum.PayAtDoor.rawValue
            case .none:
                break
            case .Stripe , .Stripe3DS:
                SRSessionManager.shared.orderEvent.paymentType = PaymentTypeEnum.Stripe.rawValue
            case .some(.Other):
                break
            }
        }
    }
    
    private func setBankTransferUI() {
        delegate?.isEnabledNextButton(enabled: viewModel.isSelected)
    }
    
    @objc func openPaymentList() {
        let listPopupViewController = ListPopUpViewController(viewModel: ListPopUpViewModel(listType: .payment, supportedPaymentMethods: viewModel.getSupportedPaymentList()))
        listPopupViewController.paymentDelegate = self
        popUp(listPopupViewController)
    }
    
    private func validateCreditCardFields(showAlert: Bool) {
        viewModel.isValid(success: { [weak self] in
            self?.delegate?.isEnabledNextButton(enabled: true)
        }) { [weak self] (errorViewModel) in
            if (errorViewModel.isValidationError && showAlert) {
                self?.showAlertError(viewModel: errorViewModel)
                DispatchQueue.main.async {
                    self?.view.endEditing(true)
                }
            }
            self?.delegate?.isEnabledNextButton(enabled: false)
        }
    }
    
}

extension CheckOutPaymentViewController: ListPopUpPaymentDelegate {
    func getSelectedPayment(payment: PaymentTypeEnum) {
        viewModel.paymentType = payment
        self.configureEmptyView()
        self.view.layoutIfNeeded()
    }
    
}

extension CheckOutPaymentViewController: MaskedTextFieldDelegateListener {
    open func textField( _ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        if textField == creditCartNumberTextField {
            self.viewModel.creditCardNumber = value
            creditCartImageView.image = textField.text?.creditCardBrand
        }
        if textField == creditCartExpireDateTextField {
            if let expireDate = creditCartExpireDateTextField.text , expireDate.count == 5 {
                self.viewModel.creditCardExpireMonth = expireDate.components(separatedBy: "/")[0]
                self.viewModel.creditCardExpireYear = "20" + expireDate.components(separatedBy: "/")[1]
            }
        }
        if textField == creditCartCvvTextField {
            self.viewModel.creditCardCvv = value
        }
    }
    
}

extension CheckOutPaymentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case creditCartHolderNameTextField:
            creditCartNumberTextField.becomeFirstResponder()
        case creditCartNumberTextField:
            creditCartExpireDateTextField.becomeFirstResponder()
        case creditCartExpireDateTextField:
            creditCartCvvTextField.becomeFirstResponder()
        case creditCartCvvTextField:
            validateCreditCardFields(showAlert: true)
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (viewModel.paymentType == .Online || viewModel.paymentType == .Online3DS) {
            validateCreditCardFields(showAlert: false)
        }
    }
}

extension CheckOutPaymentViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBankAccountCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getBankAccountModel(position: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: BankTransferTableViewCell.reuseIdentifier, for: indexPath) as! BankTransferTableViewCell
        viewModel.isSelected = viewModel.selectedBankIndex == indexPath.row
        if (viewModel.isSelected) {
            setBankTransferUI()
        }
        cell.configureBankList(model: model,index: indexPath.row, isSelected: viewModel.isSelected)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedBankIndex = indexPath.row
        bankTransferTableView.reloadData()
        SRSessionManager.shared.orderEvent.bankAccount = viewModel.getBankAccountModel(position: indexPath.row )
        bankTransferTableView.reloadData()
    }
}

extension CheckOutPaymentViewController: BankTransferCellDelegate {
    func tappedCopyIbanButton() {
        var style = ToastStyle()
        style.backgroundColor = .veryLightPink
        style.messageColor = .textPrimary
        style.messageFont = .regular12
        self.view.makeToast(String(format: "e_commerce_order_details_bank_copy_toast_message".localized),position: ToastPosition.bottom,style: style)
    }
    
}
