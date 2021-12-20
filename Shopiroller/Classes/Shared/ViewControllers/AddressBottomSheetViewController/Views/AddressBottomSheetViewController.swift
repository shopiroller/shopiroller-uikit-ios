//
//  AddressBottomSheetViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation
import UIKit

protocol AddressBottomViewDelegate {
    func closeButtonTapped()
    func saveButtonTapped()
}

class AddressBottomSheetViewController : BaseViewController<AddressBottomSheetViewModel> {
    
    private struct Constants {
        
        static var titleText: String { return "address-bottom-view-title-text".localized }
        
        static var nameTextFieldText : String { return "address-bottom-view-name-text".localized }
        
        static var surNameTextFieldText : String { return "address-bottom-view-surname-text".localized }
        
        static var phoneTextFieldText : String { return "address-bottom-view-phone-text".localized }
        
        static var countryTextFieldText : String { return "address-bottom-view-country-text".localized }
        
        static var addressTextFieldText : String { return "address-bottom-view-address-text".localized }
        
        static var zipCodeTextFieldText : String { return "address-bottom-view-zipcode-text".localized }
        
        static var addressTitleTextFieldText : String { return "address-bottom-view-address-title-text".localized }
        
        static var individualTextFieldText : String { return "address-bottom-view-individual-checkbox-text".localized }
        
        static var corporateCheckBoxText : String { return "address-bottom-view-corporate-checkbox-text".localized }
        
        static var identityNumberTextFieldText : String { return "address-bottom-view-identitynumber-text".localized }
        
        static var companyNameTextFieldText : String { return "address-bottom-view-corporate-company-name-text".localized }
        
        static var corporateTaxOfficeTextFieldText : String { return "address-bottom-view-corporate-tax-office-text".localized }
        
        static var corporateTaxNumberTextFieldText : String { return "address-bottom-view-corporate-tax-number-text".localized }
        
        static var saveButtonText : String { return "address-bottom-view-save-button-text".localized }
        
        static var saveAsBillingAddressText: String { return "address-bottom-view-save-as-billing-address-text".localized }
        
        static var statesTextFieldText: String { return "address-bottom-view-states-text".localized }
        
        static var districtTextFieldText: String { return "address-bottom-view-district-text".localized }
        
    }
    
    
    private struct ErrorConstants {
       
        static var nameEmptyError : String { return "address-bottom-view-name-empty-text".localized }
        
        static var nameValidationError : String { return "address-bottom-view-name-invalid-text".localized }
        
        static var surnameEmptyError : String { return "address-bottom-view-surname-empty-text".localized }
        
        static var surnameValidationError : String { return "address-bottom-view-surname-invalid-text".localized }
        
        static var phoneEmptyError : String { return "address-bottom-view-phone-empty-text".localized }
        
        static var phoneValidationError : String { return "address-bottom-view-phone-invalid-text".localized }
        
        static var countryError : String { return "address-bottom-view-country-error-text".localized }
        
        static var stateError : String { return "address-bottom-view-states-error-text".localized }
        
        static var districtError : String { return "address-bottom-view-district-error-text".localized }
        
        static var addressEmptyError : String { return "address-bottom-view-address-empty-text".localized }
        
        static var addressValidationError : String { return "address-bottom-view-address-invalid-text".localized }
        
        static var zipCodeEmptyError : String { return "address-bottom-view-zipcode-empty-text".localized }
        
        static var zipCodeValidationError : String { return "address-bottom-view-zipcode-invalid-text".localized }
        
        static var addressTitleEmptyError : String { return "address-bottom-view-address-title-empty-text".localized }
        
        static var addressTitleValidationError : String { return "address-bottom-view-address-title-invalid-text".localized }
        
        static var identityNumberEmptyError : String { return "address-bottom-view-identitynumber-error-text".localized }
        
        static var identityNumberValidationError : String { return "address-bottom-view-identitynumber-invalid-text".localized }
        
        static var companyNameEmptyError : String { return "address-bottom-view-corporate-company-name-error-text".localized }
        
        static var taxOfficeEmptyError : String { return "address-bottom-view-corporate-tax-office-error-text".localized }
        
        static var taxNumberEmptyError : String { return "address-bottom-view-corporate-tax-number-error-text".localized }
    }
    
    @IBOutlet private weak var topViewContainer: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameView: SRTextField!
    @IBOutlet private weak var surnameView: SRTextField!
    @IBOutlet private weak var phoneNumberView: SRTextField!
    @IBOutlet private weak var countryView: SRTextField!
    @IBOutlet private weak var addressView: SRTextField!
    @IBOutlet private weak var zipCodeView: SRTextField!
    @IBOutlet private weak var addressTitleView: SRTextField!
    @IBOutlet private weak var individualCheckBoxButton: UIButton!
    @IBOutlet private weak var individualCheckBoxTitle: UILabel!
    @IBOutlet private weak var corporateCheckBoxButton: UIButton!
    @IBOutlet private weak var corporateCheckBoxTitle: UILabel!
    @IBOutlet private weak var identityNumberContainer: UIView!
    @IBOutlet private weak var identityNumberView: SRTextField!
    @IBOutlet private weak var corporateContainer: UIView!
    @IBOutlet private weak var companyNameView: SRTextField!
    @IBOutlet private weak var taxOfficeView: SRTextField!
    @IBOutlet private weak var taxNumberView: SRTextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var billingAddressContainer: UIView!
    @IBOutlet private weak var saveAsBillingAddressButton: UIButton!
    @IBOutlet private weak var saveAsBillingAddressTitle: UILabel!
    @IBOutlet private weak var saveAsBillingContainer: UIView!
    @IBOutlet private weak var statesContainerView: UIView!
    @IBOutlet private weak var citiesContainerView: UIView!
    @IBOutlet private weak var statesView: SRTextField!
    @IBOutlet private weak var districtView: SRTextField!
    
    
    var delegate: AddressBottomViewDelegate?
    
    var isBillingAddressChecked: Bool = true
    
    var isIndividualButtonTapped: Bool = true
    
    
    init(viewModel: AddressBottomSheetViewModel){
        super.init(viewModel: viewModel, nibName: AddressBottomSheetViewController.nibName, bundle: Bundle(for: AddressBottomSheetViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        closeButton.tintColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"))
        closeButton.imageView?.tintColor = .black
        
        titleLabel.text = Constants.titleText
        titleLabel.textColor = .textPrimary
        titleLabel.font = .semiBold16
        
        saveAsBillingAddressButton.setImage(UIImage(systemName: "checkmark.circle"))
        saveAsBillingAddressButton.imageView?.tintColor = .black
        
        individualCheckBoxButton.setImage(.radioOn)
        individualCheckBoxTitle.text = Constants.individualTextFieldText
        corporateCheckBoxTitle.text = Constants.corporateCheckBoxText
        corporateCheckBoxButton.setImage(.radioOff)
        
        saveAsBillingAddressTitle.text = Constants.saveAsBillingAddressText
        saveAsBillingAddressTitle.textColor = .black
        saveAsBillingAddressTitle.font = .semiBold14
        
        saveButton.setTitle(Constants.saveButtonText)
        saveButton.titleLabel?.font = .semiBold15
        saveButton.backgroundColor = .black
        saveButton.tintColor = .white
        
        nameView.textField.placeholder = Constants.nameTextFieldText
        nameView.textField.returnKeyType = .next
        nameView.textField.delegate = self
        nameView.textField.keyboardType = .alphabet
        nameView.textField.addNextAction(target: self, selector: #selector(nextActionNameTextField))
        
        surnameView.textField.placeholder = Constants.surNameTextFieldText
        surnameView.textField.returnKeyType = .next
        surnameView.textField.delegate = self
        surnameView.textField.keyboardType = .alphabet
        surnameView.textField.addNextAction(target: self, selector: #selector(nextActionSurnameTextField))
        
        phoneNumberView.textField.placeholder = Constants.phoneTextFieldText
        phoneNumberView.textField.returnKeyType = .next
        phoneNumberView.textField.delegate = self
        phoneNumberView.textField.keyboardType = .numberPad
        phoneNumberView.textField.addNextAction(target: self, selector: #selector(nextActionPhoneNumberTextField))
        
        countryView.textField.placeholder = Constants.countryTextFieldText
        countryView.setup(rightViewImage: .arrowDown)
        countryView.textField.returnKeyType = .done
        countryView.textField.keyboardType = .alphabet
        countryView.textField.delegate = self
        countryView.textField.addCustomTextAction(title: Constants.statesTextFieldText, target: self, selector: #selector(nextActionCountryTextField))
        
        statesView.textField.placeholder = Constants.statesTextFieldText
        statesView.setup(rightViewImage: .arrowDown)
        statesView.textField.returnKeyType = .done
        statesView.textField.keyboardType = .alphabet
        statesView.textField.delegate = self
        statesView.textField.addCustomTextAction(title: Constants.districtTextFieldText, target: self, selector: #selector(nextActionStateTextField))
        
        districtView.textField.placeholder = Constants.districtTextFieldText
        districtView.setup(rightViewImage: .arrowDown)
        districtView.textField.returnKeyType = .done
        districtView.textField.keyboardType = .numberPad
        districtView.textField.delegate = self
        districtView.textField.addCustomTextAction(title: Constants.addressTextFieldText, target: self, selector: #selector(nextActionCitiesTextField))
        
        addressView.textField.placeholder = Constants.addressTextFieldText
        addressView.textField.returnKeyType = .next
        addressView.textField.delegate = self
        addressView.textField.keyboardType = .alphabet
        addressView.textField.addNextAction(target: self, selector: #selector(nextActionAddressTextField))
        
        zipCodeView.textField.placeholder = Constants.zipCodeTextFieldText
        zipCodeView.textField.returnKeyType = .next
        zipCodeView.textField.delegate = self
        zipCodeView.textField.keyboardType = .numberPad
        zipCodeView.textField.addNextAction(target: self, selector: #selector(nextActionZipCodeTextField))
        
        addressTitleView.textField.placeholder = Constants.addressTitleTextFieldText
        addressTitleView.textField.returnKeyType = .next
        addressTitleView.textField.delegate = self
        addressTitleView.textField.keyboardType = .alphabet
        addressTitleView.textField.addNextAction(target: self, selector: #selector(nextActionAddressTitleTextField))
        
        identityNumberView.textField.placeholder = Constants.identityNumberTextFieldText
        identityNumberView.textField.returnKeyType = .done
        identityNumberView.textField.delegate = self
        identityNumberView.textField.keyboardType = .numberPad
        identityNumberView.textField.addCustomTextAction(title: "keyboard-done-action-text".localized, target: self, selector: #selector(toolbarDoneButtonClicked))

        
        companyNameView.textField.placeholder = Constants.companyNameTextFieldText
        companyNameView.textField.returnKeyType = .next
        companyNameView.textField.delegate = self
        companyNameView.textField.keyboardType = .alphabet
        companyNameView.textField.addNextAction(target: self, selector: #selector(nextActionCompanyNameTextField))
        
        taxOfficeView.textField.placeholder = Constants.corporateTaxOfficeTextFieldText
        taxOfficeView.textField.returnKeyType = .next
        taxOfficeView.textField.delegate = self
        taxOfficeView.textField.keyboardType = .alphabet
        taxOfficeView.textField.addNextAction(target: self, selector: #selector(nextActionTaxOfficeTextField))
        
        taxNumberView.textField.placeholder = Constants.corporateTaxNumberTextFieldText
        taxNumberView.textField.returnKeyType = .done
        taxNumberView.textField.delegate = self
        taxNumberView.textField.keyboardType = .numberPad
        taxNumberView.textField.addCustomTextAction(title: "keyboard-done-action-text".localized, target: self, selector: #selector(toolbarDoneButtonClicked))
        
        let tapCountryTextField = UITapGestureRecognizer(target: self, action: #selector(countryViewTapped))
        countryView.textField.backgroundColor = .clear
        countryView.textField.isUserInteractionEnabled = true
        countryView.textField.addGestureRecognizer(tapCountryTextField)
        
        let tapStatesTextField = UITapGestureRecognizer(target: self, action: #selector(statesViewTapped))
        statesView.textField.backgroundColor = .clear
        statesView.textField.isUserInteractionEnabled = true
        statesView.textField.addGestureRecognizer(tapStatesTextField)
        
        let tapCitiesTextField = UITapGestureRecognizer(target: self, action: #selector(citiesViewTapped))
        districtView.textField.backgroundColor = .clear
        districtView.textField.isUserInteractionEnabled = true
        districtView.textField.addGestureRecognizer(tapCitiesTextField)
        
        topViewContainer.backgroundColor = .iceBlue
        
        getCountryList()
        setUpLayout()
        if viewModel.isEditAvailable() {
            setEditBinds()
            statesContainerView.isHidden = false
            citiesContainerView.isHidden = false
        }
        
    }
    
    //MARK: - Actions
    
    @objc func nextActionNameTextField() {
        _ = textFieldShouldReturn(nameView.textField)
    }
    
    @objc func nextActionSurnameTextField() {
        _ = textFieldShouldReturn(surnameView.textField)
    }
    
    @objc func nextActionPhoneNumberTextField() {
        _ = textFieldShouldReturn(phoneNumberView.textField)
    }
    
    @objc func nextActionCountryTextField() {
        _ = textFieldShouldReturn(countryView.textField)
    }
    
    @objc func nextActionStateTextField() {
        _ = textFieldShouldReturn(statesView.textField)
    }
    
    @objc func nextActionCitiesTextField() {
        _ = textFieldShouldReturn(districtView.textField)
    }
    
    @objc func nextActionAddressTextField() {
        _ = textFieldShouldReturn(addressView.textField)
    }
    
    @objc func nextActionZipCodeTextField() {
        _ = textFieldShouldReturn(zipCodeView.textField)
    }
    
    @objc func nextActionAddressTitleTextField() {
        _ = textFieldShouldReturn(addressTitleView.textField)
    }
    
    @objc func nextActionCompanyNameTextField() {
        _ = textFieldShouldReturn(companyNameView.textField)
    }
    
    @objc func nextActionTaxOfficeTextField() {
        _ = textFieldShouldReturn(taxOfficeView.textField)
    }
    
    @objc func toolbarDoneButtonClicked() {
        saveButtonTapped()
    }
    
    private func setUpLayout() {
        switch viewModel.getAddressType() {
        case .billing:
            saveAsBillingContainer.isHidden = true
        case .shipping:
            saveAsBillingContainer.isHidden = false
        }
        setBillingAddressRadioButtons()
    }
    
    @IBAction func saveAsBillingAddressButtonTapped() {
        isBillingAddressChecked = !isBillingAddressChecked
        setBillingAddressButton()
    }
    
    private func setBillingAddressButton() {
        if isBillingAddressChecked {
            billingAddressContainer.isHidden = false
            saveAsBillingAddressButton.setImage(UIImage(systemName: "checkmark.circle"))
        }else {
            billingAddressContainer.isHidden = true
            saveAsBillingAddressButton.setImage(UIImage(systemName: "circle"))
        }
    }
    
    @IBAction func individualButtonTapped() {
        isIndividualButtonTapped = !isIndividualButtonTapped
        setBillingAddressRadioButtons()
    }
    
    @IBAction func corporateButtonTapped() {
        isIndividualButtonTapped = !isIndividualButtonTapped
        setBillingAddressRadioButtons()
    }
    
    private func setBillingAddressRadioButtons() {
        if isIndividualButtonTapped {
            identityNumberContainer.isHidden = false
            corporateContainer.isHidden = true
            individualCheckBoxButton.setImage(.radioOn)
            corporateCheckBoxButton.setImage(.radioOff)
        } else {
            billingAddressContainer.isHidden = false
            identityNumberContainer.isHidden = true
            corporateContainer.isHidden = false
            individualCheckBoxButton.setImage(.radioOff)
            corporateCheckBoxButton.setImage(.radioOn)
        }
    }
    
    @IBAction func closeBottomSheet() {
        delegate?.closeButtonTapped()
    }
    
    @IBAction func saveButtonTapped() {
        if isValid() {
            if viewModel.isEditAvailable(){
                editAddress()
            }else {
                saveAddress()
            }
        }
    }
    
    
    @objc func countryViewTapped() {
        nameView.resignFirstResponder()
        surnameView.resignFirstResponder()
        phoneNumberView.resignFirstResponder()
        addressView.resignFirstResponder()
        zipCodeView.resignFirstResponder()
        identityNumberView.resignFirstResponder()
        companyNameView.resignFirstResponder()
        taxNumberView.resignFirstResponder()
        taxOfficeView.resignFirstResponder()
        addressTitleView.resignFirstResponder()
        self.viewModel.selectionType = .country
        statesView.textField.isEnabled = true
        statesView.textField.placeholder = Constants.statesTextFieldText
        citiesContainerView.isHidden = true
        let vc = SelectionPopUpViewController(viewModel: SelectionPopUpViewModel(selectionList: viewModel.getCountries(), type: .country))
        vc.delegate = self
        popUp(vc)
    }
    
    @objc func statesViewTapped() {
        nameView.resignFirstResponder()
        surnameView.resignFirstResponder()
        phoneNumberView.resignFirstResponder()
        addressView.resignFirstResponder()
        zipCodeView.resignFirstResponder()
        identityNumberContainer.resignFirstResponder()
        companyNameView.resignFirstResponder()
        taxNumberView.resignFirstResponder()
        taxOfficeView.resignFirstResponder()
        addressTitleView.resignFirstResponder()
        self.viewModel.selectionType = .state
        districtView.textField.isEnabled = true
        districtView.textField.text = ""
        let vc = SelectionPopUpViewController(viewModel: SelectionPopUpViewModel(selectionList: viewModel.getStates(), type: .state))
        vc.delegate = self
        popUp(vc)
    }
    
    @objc func citiesViewTapped() {
        nameView.resignFirstResponder()
        surnameView.resignFirstResponder()
        phoneNumberView.resignFirstResponder()
        addressView.resignFirstResponder()
        zipCodeView.resignFirstResponder()
        companyNameView.resignFirstResponder()
        taxNumberView.resignFirstResponder()
        identityNumberContainer.resignFirstResponder()
        taxOfficeView.resignFirstResponder()
        addressTitleView.resignFirstResponder()
        self.viewModel.selectionType = .city
        let vc = SelectionPopUpViewController(viewModel: SelectionPopUpViewModel(selectionList: viewModel.getCities(), type: .city))
        vc.delegate = self
        popUp(vc)
    }
    
    private func getCountryList() {
        viewModel.getCountryModel(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getStateList() {
        viewModel.getStateModel(success: {
            [weak self] in
            if self?.viewModel.getStates().count != 0 {
                self?.statesContainerView.isHidden = false
            } else {
                self?.statesContainerView.isHidden = true
            }
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func getCitiesList() {
        viewModel.getCityModel(success: {
            [weak self] in
            if self?.viewModel.getCities().count != 0 {
                self?.citiesContainerView.isHidden = false
                if self?.viewModel.getCities().count == 1 {
                    self?.districtView.textField.text = self?.viewModel.getCities()[0].name
                    self?.districtView.textField.isEnabled = true
                }
            }else {
                self?.citiesContainerView.isHidden = true
            }
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    private func isValid() -> Bool {
        var isValid : Bool = true
        if (nameView.textField.text == "") {
            nameView.setError(errorMessage: ErrorConstants.nameEmptyError)
            isValid = false;
        } else if (nameView.textField.text?.count ?? 0 < 3) {
            nameView.setError(errorMessage: ErrorConstants.nameValidationError)
            isValid = false;
        } else {
            nameView.errorLabel != nil ? nameView.setInfoLabel() : nameView.removeError()
        }
        if (surnameView.textField.text == "") {
            surnameView.setError(errorMessage: ErrorConstants.surnameEmptyError)
            isValid = false
        } else if (surnameView.textField.text?.count ?? 0 < 3) {
            surnameView.setError(errorMessage: ErrorConstants.surnameValidationError)
            isValid = false
        } else {
            surnameView.errorLabel != nil ? surnameView.setInfoLabel() : surnameView.removeError()
        }
        if (phoneNumberView.textField.text == "") {
            phoneNumberView.setError(errorMessage: ErrorConstants.phoneEmptyError)
            isValid = false
        } else if (phoneNumberView.textField.text?.count ?? 0 < 11) {
            phoneNumberView.setError(errorMessage: ErrorConstants.phoneValidationError)
            isValid = false
        } else {
            phoneNumberView.removeError()
        }
        if ((countryView.textField.text == "" && countryView.textField.placeholder != "") && !viewModel.isEditAvailable()) {
            countryView.setError(errorMessage: ErrorConstants.countryError)
            isValid = false
        } else {
            countryView.removeError()
        }
        if (statesContainerView.isHidden == false) {
            if((statesView.textField.text == "" && statesView.textField.placeholder != "") && !viewModel.isEditAvailable()) {
                statesView.setError(errorMessage: ErrorConstants.stateError)
                isValid = false
            } else {
                statesView.removeError()
            }
        }
        if (citiesContainerView.isHidden == false) {
            if((districtView.textField.text == "" && districtView.textField.placeholder != "") && !viewModel.isEditAvailable()) {
                districtView.setError(errorMessage: ErrorConstants.districtError)
                isValid = false
            } else {
                districtView.removeError()
            }
        }
        if (addressView.textField.text == "") {
            addressView.setError(errorMessage: ErrorConstants.addressEmptyError)
            isValid = false
        } else if (addressView.textField.text?.count ?? 0 < 3) {
            addressView.setError(errorMessage: ErrorConstants.addressValidationError)
            isValid = false
        } else {
            addressView.removeError()
        }
        if (zipCodeView.textField.text == "") {
            zipCodeView.setError(errorMessage: ErrorConstants.zipCodeEmptyError)
            isValid = false
        } else if (zipCodeView.textField.text?.count ?? 0 < 3) {
            zipCodeView.setError(errorMessage: ErrorConstants.zipCodeValidationError)
            isValid = false
        } else {
            zipCodeView.removeError()
        }
        if (addressView.textField.text == "") {
            addressTitleView.setError(errorMessage: ErrorConstants.addressTitleEmptyError)
            isValid = false
        } else if (addressView.textField.text?.count ?? 0 < 2) {
            addressView.setError(errorMessage: ErrorConstants.addressTitleValidationError)
            isValid = false
        } else {
            addressView.removeError()
        }
        
        if (viewModel.isEditAvailable() && viewModel.userShippingAddress != nil) {
            return isValid
        }
        if (viewModel.getAddressType() == .shipping && !isBillingAddressChecked) {
            return isValid
        }
        
        if billingAddressContainer.isHidden == false {
            if isIndividualButtonTapped {
                if (identityNumberView.textField.text == "") {
                    identityNumberView.setError(errorMessage: ErrorConstants.identityNumberEmptyError)
                    isValid = false;
                } else if (identityNumberView.textField.text?.count ?? 0 < 11) {
                    identityNumberView.setError(errorMessage: ErrorConstants.identityNumberValidationError)
                    isValid = false;
                }
            }else {
                if (companyNameView.textField.text == "") {
                    companyNameView.setError(errorMessage: ErrorConstants.companyNameEmptyError)
                    isValid = false;
                }
                if (taxOfficeView.textField.text == "") {
                    taxOfficeView.setError(errorMessage: ErrorConstants.taxOfficeEmptyError)
                    isValid = false;
                }
                if (taxNumberView.textField.text == "") {
                    taxNumberView.setError(errorMessage: ErrorConstants.taxNumberEmptyError)
                    isValid = false;
                }
                }

    }
        return isValid
    }
    
    private func editAddress() {
        switch viewModel.getAddressType() {
        case .billing:
            if let userBillingAddress = viewModel.getBillingAddress(){
                var editBillingAddress: EditAddressModel? = EditAddressModel()
                editBillingAddress?.apiKey = SRNetworkContext.apiKey
                editBillingAddress?.appKey = SRNetworkContext.appKey
                editBillingAddress?.addressLine = addressView.textField.text
                editBillingAddress?.country = countryView.textField.text
                editBillingAddress?.state = statesView.textField.placeholder
                editBillingAddress?.city = districtView.textField.placeholder
                editBillingAddress?.phone = phoneNumberView.textField.text
                editBillingAddress?.zipCode = zipCodeView.textField.text
                editBillingAddress?.title = addressTitleView.textField.text
                editBillingAddress?.nameSurname = (nameView.textField.text ?? "") + " " + (surnameView.textField.text ?? "")
                editBillingAddress?.id = userBillingAddress.id
                if isIndividualButtonTapped {
                    editBillingAddress?.type = "Individual"
                    editBillingAddress?.identityNumber = identityNumberView.textField.text
                }else {
                    editBillingAddress?.type = "Corporate"
                    editBillingAddress?.companyName = companyNameView.textField.text
                    editBillingAddress?.taxNumber = taxNumberView.textField.text
                    editBillingAddress?.taxOffice = taxOfficeView.textField.text
                }
                viewModel.editAddressModel = editBillingAddress ?? EditAddressModel()
                saveBillingAddress(isEditing: true)
            }
            
        case .shipping:
            if let userShippingAddress = viewModel.getShippingAddress() {
                var editShippingAddress: EditAddressModel? = EditAddressModel()
                editShippingAddress?.apiKey = SRNetworkContext.apiKey
                editShippingAddress?.appKey = SRNetworkContext.appKey
                editShippingAddress?.addressLine = addressView.textField.text
                editShippingAddress?.country = countryView.textField.text
                editShippingAddress?.state = statesView.textField.placeholder
                editShippingAddress?.city = districtView.textField.placeholder
                editShippingAddress?.phone = phoneNumberView.textField.text
                editShippingAddress?.zipCode = zipCodeView.textField.text
                editShippingAddress?.title = addressTitleView.textField.text
                editShippingAddress?.nameSurname = (nameView.textField.text ?? "") + " " + (surnameView.textField.text ?? "")
                editShippingAddress?.id = userShippingAddress.id
                if isIndividualButtonTapped {
                    editShippingAddress?.type = "Individual"
                    editShippingAddress?.identityNumber = identityNumberView.textField.text
                }else {
                    editShippingAddress?.type = "Corporate"
                    editShippingAddress?.companyName = companyNameView.textField.text
                    editShippingAddress?.taxNumber = taxNumberView.textField.text
                    editShippingAddress?.taxOffice = taxOfficeView.textField.text
                }
                viewModel.editAddressModel = editShippingAddress ?? EditAddressModel()
                saveShippingAddress(isEditing: true)
            }
        }
    }
    
    private func setEditBinds() {
        switch viewModel.getAddressType() {
        case .shipping:
            if let userShippingAddress = viewModel.getShippingAddress(){
                saveAsBillingContainer.isHidden = true
                billingAddressContainer.isHidden = true
                let names : [String] = userShippingAddress.contact?.nameSurname?.components(separatedBy: " ") ?? []
                surnameView.textField.text = names[names.count - 1]
                for i in 0..<(names.count - 1){
                    if i == 0 {
                        nameView.textField.text = names[0]
                    }else {
                        nameView.textField.text = nameView.textField.text ?? "" + names[i]
                    }
                }
                phoneNumberView.textField.text = userShippingAddress.contact?.phoneNumber
                addressView.textField.text = userShippingAddress.addressLine
                countryView.textField.text = userShippingAddress.country
                districtView.textField.placeholder = userShippingAddress.city
                statesView.textField.placeholder = userShippingAddress.state
                zipCodeView.textField.text = userShippingAddress.zipCode
                addressTitleView.textField.text = userShippingAddress.title
            }
            
        case .billing:
            if let userBillingAddress = viewModel.getBillingAddress() {
                saveAsBillingContainer.isHidden = true
                billingAddressContainer.isHidden = false
                let names : [String] = userBillingAddress.contact?.nameSurname?.components(separatedBy: " ") ?? []
                surnameView.textField.text = names[names.count - 1]
                for i in 0..<(names.count - 1){
                    if i == 0 {
                        nameView.textField.text = names[0]
                    }else {
                        nameView.textField.text = nameView.textField.text ?? "" + names[i]
                    }
                }
                phoneNumberView.textField.text = userBillingAddress.contact?.phoneNumber
                addressView.textField.text = userBillingAddress.addressLine
                countryView.textField.text = userBillingAddress.country
                districtView.textField.placeholder = userBillingAddress.city
                statesView.textField.placeholder = userBillingAddress.state
                zipCodeView.textField.text = userBillingAddress.zipCode
                addressTitleView.textField.text = userBillingAddress.title
                if userBillingAddress.type != nil && userBillingAddress.type?.lowercased() == "corporate"{
                    isIndividualButtonTapped = false
                    companyNameView.textField.text = userBillingAddress.companyName
                    taxOfficeView.textField.text = userBillingAddress.taxOffice
                    taxNumberView.textField.text = userBillingAddress.taxNumber
                }
                else {
                    self.isIndividualButtonTapped = true
                    identityNumberView.textField.text = userBillingAddress.identityNumber
                }
            }
        }
        districtView.textField.isEnabled = false
        statesView.textField.isEnabled = false
    }
    
    private func saveAddress() {
        switch viewModel.getAddressType() {
        case .shipping:
            viewModel.addAddressModel.apiKey = SRNetworkContext.apiKey
            viewModel.addAddressModel.appKey = SRNetworkContext.appKey
            viewModel.addAddressModel.addressLine = addressView.textField.text
            viewModel.addAddressModel.country = countryView.textField.text
            viewModel.addAddressModel.state = statesView.textField.text
            viewModel.addAddressModel.city = districtView.textField.text
            viewModel.addAddressModel.phone = phoneNumberView.textField.text
            viewModel.addAddressModel.zipCode = zipCodeView.textField.text
            viewModel.addAddressModel.title = addressTitleView.textField.text
            viewModel.addAddressModel.nameSurname = (nameView.textField.text ?? "") + " " + (surnameView.textField.text ?? "")
            viewModel.addAddressModel.addBoth = isBillingAddressChecked
            if isIndividualButtonTapped {
                viewModel.addAddressModel.type = "Individual"
                viewModel.addAddressModel.identityNumber = identityNumberView.textField.text
            }else {
                viewModel.addAddressModel.type = "Corporate"
                viewModel.addAddressModel.companyName = companyNameView.textField.text
                viewModel.addAddressModel.taxNumber = taxNumberView.textField.text
                viewModel.addAddressModel.taxOffice = taxOfficeView.textField.text
            }
            if viewModel.addAddressModel.addBoth == true {
                addAddress()
            } else {
                saveShippingAddress(isEditing: false)
            }
        case .billing:
            viewModel.addAddressModel.apiKey = SRNetworkContext.apiKey
            viewModel.addAddressModel.appKey = SRNetworkContext.appKey
            viewModel.addAddressModel.addressLine = addressView.textField.text
            viewModel.addAddressModel.city = districtView.textField.text
            viewModel.addAddressModel.country = countryView.textField.text
            viewModel.addAddressModel.state = statesView.textField.text
            viewModel.addAddressModel.zipCode = zipCodeView.textField.text
            viewModel.addAddressModel.phone = phoneNumberView.textField.text
            viewModel.addAddressModel.nameSurname = (nameView.textField.text ?? "") + " " + (surnameView.textField.text ?? "")
            viewModel.addAddressModel.title = addressTitleView.textField.text
            if isIndividualButtonTapped {
                viewModel.addAddressModel.type = "Individual"
                viewModel.addAddressModel.identityNumber = identityNumberView.textField.text
            }else {
                viewModel.addAddressModel.type = "Corporate"
                viewModel.addAddressModel.companyName = companyNameView.textField.text
                viewModel.addAddressModel.taxNumber = taxNumberView.textField.text
                viewModel.addAddressModel.taxOffice = taxOfficeView.textField.text
            }
            saveBillingAddress(isEditing: false)
        }
        
    }
    
    private func saveShippingAddress(isEditing: Bool) {
        if isEditing {
            viewModel.saveEdittedShippingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped()
                self.pop(animated: true, completion: nil)
            }) {
                [weak self] (errorViewModel) in
                guard let self = self else { return }
            }
        } else {
            viewModel.addShippingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped()
                self.pop(animated: true, completion: nil)
            }) {
                [weak self] (errorViewModel) in
                guard let self = self else { return }
            }
        }
        
        
    }
    
    private func saveBillingAddress(isEditing: Bool) {
        if isEditing {
            viewModel.saveEdittedBillingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped()
                self.pop(animated: true, completion: nil)
            }) {
                [weak self] (errorViewModel) in
                guard let self = self else { return }
            }
        } else {
            viewModel.addBillingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped()
                self.pop(animated: true, completion: nil)
            }) {
                [weak self] (errorViewModel) in
                guard let self = self else { return }
            }
        }
       
    }
    
    private func addAddress() {
        viewModel.addAddress(success: {
            [weak self] in
            guard let self = self else { return }
            
            self.delegate?.saveButtonTapped()
            self.pop(animated: true, completion: nil)
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
        
    }
}

extension AddressBottomSheetViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == countryView) {
            countryViewTapped()
            return false
        }
        if (textField == statesView){
            statesViewTapped()
            return false
        }
        if (textField == districtView){
            citiesViewTapped()
            return false
        }
        return true;
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case nameView:
            surnameView.becomeFirstResponder()
        case surnameView:
            phoneNumberView.becomeFirstResponder()
        case phoneNumberView:
            countryView.becomeFirstResponder()
        case countryView:
            statesView.becomeFirstResponder()
        case statesView:
            districtView.becomeFirstResponder()
        case districtView:
            addressView.becomeFirstResponder()
        case addressView:
            zipCodeView.becomeFirstResponder()
        case zipCodeView:
            addressTitleView.becomeFirstResponder()
        case addressTitleView:
            identityNumberView.becomeFirstResponder()
        case identityNumberContainer:
            return true
        case companyNameView:
            taxOfficeView.becomeFirstResponder()
        case taxOfficeView:
            taxNumberView.becomeFirstResponder()
        case taxNumberView:
            return true
        default:
            break
        }
        return true
    }
}

extension AddressBottomSheetViewController: SelectionPopoUpDelegate {
    func getCountryId(id: String?, type: SelectionType?) {
        switch type {
        case .country:
            self.viewModel.countryId = id ?? ""
            getStateList()
            if viewModel.getStates().count == 0 {
                statesView.textField.text = viewModel.addAddressModel.country
                districtView.textField.text = viewModel.addAddressModel.country
            }
        case .state:
            self.viewModel.stateId = id ?? ""
            getCitiesList()
            if viewModel.getCities().count == 0 {
                districtView.textField.text = viewModel.addAddressModel.country
            }
        case .city:
            break
        case .none:
            break
        }
    }
    
    func getCountryName(name: String?, type: SelectionType?) {
        switch type {
        case .country:
            countryView.textField.text = name
        case .city:
            if viewModel.getCities().count == 0 {
                viewModel.addAddressModel.city = viewModel.addAddressModel.state
            }else {
                districtView.textField.text = name
            }
        case .state:
            statesView.textField.text = name
        case .none:
            break
        }
    }   
    
}


