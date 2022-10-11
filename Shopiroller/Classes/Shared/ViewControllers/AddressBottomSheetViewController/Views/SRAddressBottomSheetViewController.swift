//
//  AddressBottomSheetViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation
import UIKit

protocol AddressBottomViewDelegate: AnyObject {
    func closeButtonTapped()
    func saveButtonTapped(userShippingAddressModel: UserShippingAddressModel? ,
                          userBillingAddressModel: UserBillingAdressModel?, defaultAddressModel : SRDefaultAddressModel?)
}

class SRAddressBottomSheetViewController : BaseViewController<SRAddressBottomSheetViewModel> {
    
    private struct Constants {
        
        static var titleText: String { return "e_commerce_address_selection_add_new_address".localized }
        
        static var nameTextFieldText : String { return "user_address_name".localized }
        
        static var surNameTextFieldText : String { return "user_address_surname".localized }
        
        static var phoneTextFieldText : String { return "user_address_phone".localized }
        
        static var countryTextFieldText : String { return "user_address_country".localized }
        
        static var addressTextFieldText : String { return "user_address_address_line".localized }
        
        static var zipCodeTextFieldText : String { return "user_address_postal_code".localized }
        
        static var addressTitleTextFieldText : String { return "user_address_address_title".localized }
        
        static var individualCheckBoxText : String { return "user_address_individual".localized }
        
        static var corporateCheckBoxText : String { return "user_address_corporate".localized }
        
        static var identityNumberTextFieldText : String { return "user_address_identity_number".localized }
        
        static var companyNameTextFieldText : String { return "user_address_company_name".localized }
        
        static var corporateTaxOfficeTextFieldText : String { return "user_address_tax_office".localized }
        
        static var corporateTaxNumberTextFieldText : String { return "user_address_tax_number".localized }
        
        static var saveButtonText : String { return "e_commerce_general_save_button_text".localized }
        
        static var saveAsBillingAddressText: String { return "user_address_save_as_billing".localized }
        
        static var statesTextFieldText: String { return "user_address_city".localized }
        
        static var districtTextFieldText: String { return "user_address_district".localized }
        
        static var keyboardDoneActionText: String { return "e_commerce_general_keyboard_done_action_text".localized }
        
    }
    
    
    private struct ErrorConstants {
        
        static var nameEmptyError : String { return "user_address_form_name_empty".localized }
        
        static var nameValidationError : String { return "user_address_form_name_valid".localized }
        
        static var surnameEmptyError : String { return "address-bottom-view-surname-empty-text".localized }
        
        static var surnameValidationError : String { return "user_address_form_surname_empty".localized }
        
        static var phoneEmptyError : String { return "user_address_form_phone_empty".localized }
        
        static var phoneValidationError : String { return "user_address_form_phone_valid".localized }
        
        static var countryError : String { return "user_address_form_country_empty".localized }
        
        static var stateError : String { return "user_address_form_city_empty".localized }
        
        static var districtError : String { return "user_address_form_district_empty".localized }
        
        static var addressEmptyError : String { return "user_address_form_address_empty".localized }
        
        static var addressValidationError : String { return "user_address_form_address_valid".localized }
        
        static var zipCodeEmptyError : String { return "user_address_form_postal_code_empty".localized }
        
        static var zipCodeValidationError : String { return "user_address_form_postal_code_valid".localized }
        
        static var addressTitleEmptyError : String { return "user_address_form_address_title_empty".localized }
        
        static var addressTitleValidationError : String { return "user_address_form_address_title_valid".localized }
        
        static var identityNumberEmptyError : String { return "user_address_form_identity_number_empty".localized }
        
        static var identityNumberValidationError : String { return "user_address_form_identity_number_valid".localized }
        
        static var companyNameEmptyError : String { return "user_address_form_company_empty".localized }
        
        static var taxOfficeEmptyError : String { return "user_address_form_tax_office_empty".localized }
        
        static var taxNumberEmptyError : String { return "user_address_form_tax_number_empty".localized }
    }
    
    @IBOutlet private weak var individualCheckBoxTitle: UILabel!
    @IBOutlet private weak var corporateCheckBoxTitle: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var saveAsBillingAddressTitle: UILabel!
    
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var saveAsBillingAddressButton: UIButton!
    @IBOutlet private weak var individualCheckBoxButton: UIButton!
    @IBOutlet private weak var corporateCheckBoxButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    
    @IBOutlet private weak var saveAsBillingContainer: UIView!
    @IBOutlet private weak var statesContainerView: UIView!
    @IBOutlet private weak var districtsContainerView: UIView!
    @IBOutlet private weak var billingAddressContainer: UIView!
    @IBOutlet private weak var identityNumberContainer: UIView!
    @IBOutlet private weak var corporateContainer: UIView!
    @IBOutlet private weak var topViewContainer: UIView!
    
    @IBOutlet private weak var nameView: SRTextField!
    @IBOutlet private weak var surnameView: SRTextField!
    @IBOutlet private weak var phoneNumberView: SRTextField!
    @IBOutlet private weak var countryView: SRTextField!
    @IBOutlet private weak var userAddressView: SRTextField!
    @IBOutlet private weak var zipCodeView: SRTextField!
    @IBOutlet private weak var addressTitleView: SRTextField!
    @IBOutlet private weak var companyNameView: SRTextField!
    @IBOutlet private weak var taxOfficeView: SRTextField!
    @IBOutlet private weak var taxNumberView: SRTextField!
    @IBOutlet private weak var statesView: SRTextField!
    @IBOutlet private weak var districtView: SRTextField!
    @IBOutlet private weak var identityNumberView: SRTextField!
    
    
    weak var delegate: AddressBottomViewDelegate?
    
    private var isBillingAddressChecked: Bool = true
    
    private var isIndividualButtonTapped: Bool = true
    
    
    init(viewModel: SRAddressBottomSheetViewModel){
        super.init(viewModel: viewModel, nibName: SRAddressBottomSheetViewController.nibName, bundle: Bundle(for: SRAddressBottomSheetViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        closeButton.setImage(UIImage(systemName: "xmark"))
        closeButton.imageView?.tintColor = .black
        
        titleLabel.text = Constants.titleText
        titleLabel.textColor = .textPrimary
        titleLabel.font = .semiBold16
        
        saveAsBillingAddressButton.setImage(UIImage(systemName: "checkmark.circle"))
        saveAsBillingAddressButton.imageView?.tintColor = .black
        
        individualCheckBoxTitle.text = Constants.individualCheckBoxText
        individualCheckBoxButton.setImage(.radioOn)
        
        corporateCheckBoxTitle.text = Constants.corporateCheckBoxText
        corporateCheckBoxButton.setImage(.radioOff)
        
        saveAsBillingAddressTitle.text = Constants.saveAsBillingAddressText
        saveAsBillingAddressTitle.textColor = .black
        saveAsBillingAddressTitle.font = .semiBold14
        
        saveButton.setTitle(Constants.saveButtonText)
        saveButton.titleLabel?.font = .semiBold15
        saveButton.backgroundColor = .black
        saveButton.tintColor = .white
        
        nameView.getTextField().placeholder = Constants.nameTextFieldText
        nameView.getTextField().returnKeyType = .next
        nameView.getTextField().delegate = self
        nameView.getTextField().keyboardType = .alphabet
        nameView.getTextField().addNextAction(target: self, selector: #selector(nextActionNameTextField))
        
        surnameView.getTextField().placeholder = Constants.surNameTextFieldText
        surnameView.getTextField().returnKeyType = .next
        surnameView.getTextField().delegate = self
        surnameView.getTextField().keyboardType = .alphabet
        surnameView.getTextField().addNextAction(target: self, selector: #selector(nextActionSurnameTextField))
        
        phoneNumberView.getTextField().placeholder = Constants.phoneTextFieldText
        phoneNumberView.getTextField().returnKeyType = .next
        phoneNumberView.getTextField().delegate = self
        phoneNumberView.getTextField().keyboardType = .numberPad
        phoneNumberView.getTextField().addNextAction(target: self, selector: #selector(nextActionPhoneNumberTextField))
        
        countryView.getTextField().placeholder = Constants.countryTextFieldText
        countryView.setup(rightViewImage: .dropdownIcon, type: .withPadding)
        countryView.getTextField().returnKeyType = .done
        countryView.getTextField().keyboardType = .alphabet
        countryView.getTextField().delegate = self
        countryView.getTextField().addCustomTextAction(title: Constants.statesTextFieldText, target: self, selector: #selector(nextActionCountryTextField))
        
        statesView.getTextField().placeholder = Constants.statesTextFieldText
        statesView.setup(rightViewImage: .dropdownIcon,type: .withPadding)
        statesView.getTextField().returnKeyType = .done
        statesView.getTextField().keyboardType = .alphabet
        statesView.getTextField().delegate = self
        statesView.getTextField().addCustomTextAction(title: Constants.districtTextFieldText, target: self, selector: #selector(nextActionStateTextField))
        
        districtView.getTextField().placeholder = Constants.districtTextFieldText
        districtView.setup(rightViewImage: .dropdownIcon,type: .withPadding)
        districtView.getTextField().returnKeyType = .done
        districtView.getTextField().keyboardType = .numberPad
        districtView.getTextField().delegate = self
        districtView.getTextField().addCustomTextAction(title: Constants.addressTextFieldText, target: self, selector: #selector(nextActionCitiesTextField))
        
        userAddressView.getTextField().placeholder = Constants.addressTextFieldText
        userAddressView.getTextField().returnKeyType = .next
        userAddressView.getTextField().delegate = self
        userAddressView.getTextField().keyboardType = .alphabet
        userAddressView.getTextField().addNextAction(target: self, selector: #selector(nextActionAddressTextField))
        
        zipCodeView.getTextField().placeholder = Constants.zipCodeTextFieldText
        zipCodeView.getTextField().returnKeyType = .next
        zipCodeView.getTextField().delegate = self
        zipCodeView.getTextField().keyboardType = .numberPad
        zipCodeView.getTextField().addNextAction(target: self, selector: #selector(nextActionZipCodeTextField))
        
        addressTitleView.getTextField().placeholder = Constants.addressTitleTextFieldText
        addressTitleView.getTextField().returnKeyType = .next
        addressTitleView.getTextField().delegate = self
        addressTitleView.getTextField().keyboardType = .alphabet
        addressTitleView.getTextField().addNextAction(target: self, selector: #selector(nextActionAddressTitleTextField))
        
        identityNumberView.getTextField().placeholder = Constants.identityNumberTextFieldText
        identityNumberView.getTextField().returnKeyType = .done
        identityNumberView.getTextField().delegate = self
        identityNumberView.getTextField().keyboardType = .numberPad
        identityNumberView.getTextField().addCustomTextAction(title: Constants.keyboardDoneActionText, target: self, selector: #selector(toolbarDoneButtonClicked))
        
        companyNameView.getTextField().placeholder = Constants.companyNameTextFieldText
        companyNameView.getTextField().returnKeyType = .next
        companyNameView.getTextField().delegate = self
        companyNameView.getTextField().keyboardType = .alphabet
        companyNameView.getTextField().addNextAction(target: self, selector: #selector(nextActionCompanyNameTextField))
        
        taxOfficeView.getTextField().placeholder = Constants.corporateTaxOfficeTextFieldText
        taxOfficeView.getTextField().returnKeyType = .next
        taxOfficeView.getTextField().delegate = self
        taxOfficeView.getTextField().keyboardType = .alphabet
        taxOfficeView.getTextField().addNextAction(target: self, selector: #selector(nextActionTaxOfficeTextField))
        
        taxNumberView.getTextField().placeholder = Constants.corporateTaxNumberTextFieldText
        taxNumberView.getTextField().returnKeyType = .done
        taxNumberView.getTextField().delegate = self
        taxNumberView.getTextField().keyboardType = .numberPad
        taxNumberView.getTextField().addCustomTextAction(title: Constants.keyboardDoneActionText, target: self, selector: #selector(toolbarDoneButtonClicked))
        
        let tapCountryTextField = UITapGestureRecognizer(target: self, action: #selector(countryViewTapped))
        countryView.getTextField().backgroundColor = .clear
        countryView.getTextField().isUserInteractionEnabled = true
        countryView.getTextField().addGestureRecognizer(tapCountryTextField)
        
        let tapStatesTextField = UITapGestureRecognizer(target: self, action: #selector(statesViewTapped))
        statesView.getTextField().backgroundColor = .clear
        statesView.getTextField().isUserInteractionEnabled = true
        statesView.getTextField().addGestureRecognizer(tapStatesTextField)
        
        let tapCitiesTextField = UITapGestureRecognizer(target: self, action: #selector(districtViewTapped))
        districtView.getTextField().backgroundColor = .clear
        districtView.getTextField().isUserInteractionEnabled = true
        districtView.getTextField().addGestureRecognizer(tapCitiesTextField)
        
        topViewContainer.backgroundColor = .iceBlue
        
        getCountryList()
        setUpLayout()
        
        if viewModel.isEditAvailable() {
            setEditBinds()
            statesContainerView.isHidden = false
            districtsContainerView.isHidden = false
            statesView.isEnabled = false
            districtView.isEnabled = false
        }
        
    }
    
    //MARK: - Actions
    
    @objc func nextActionNameTextField() {
        _ = textFieldShouldReturn(nameView.getTextField())
    }
    
    @objc func nextActionSurnameTextField() {
        _ = textFieldShouldReturn(surnameView.getTextField())
    }
    
    @objc func nextActionPhoneNumberTextField() {
        _ = textFieldShouldReturn(phoneNumberView.getTextField())
    }
    
    @objc func nextActionCountryTextField() {
        countryViewTapped()
    }
    
    @objc func nextActionStateTextField() {
        statesViewTapped()
    }
    
    @objc func nextActionCitiesTextField() {
        districtViewTapped()
    }
    
    @objc func nextActionAddressTextField() {
        _ = textFieldShouldReturn(userAddressView.getTextField())
    }
    
    @objc func nextActionZipCodeTextField() {
        _ = textFieldShouldReturn(zipCodeView.getTextField())
    }
    
    @objc func nextActionAddressTitleTextField() {
        _ = textFieldShouldReturn(addressTitleView.getTextField())
    }
    
    @objc func nextActionCompanyNameTextField() {
        _ = textFieldShouldReturn(companyNameView.getTextField())
    }
    
    @objc func nextActionTaxOfficeTextField() {
        _ = textFieldShouldReturn(taxOfficeView.getTextField())
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
        billingAddressContainer.isHidden = !isBillingAddressChecked
        isBillingAddressChecked ? saveAsBillingAddressButton.setImage(UIImage(systemName: "checkmark.circle")) : saveAsBillingAddressButton.setImage(UIImage(systemName: "circle"))
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
            if viewModel.isEditAvailable() {
                editAddress()
            } else {
                saveAddress()
            }
        }
    }
    
    
    @objc func countryViewTapped() {
        self.viewModel.selectionAddressType = .country
        showSelectionPopUp()
    }
    
    @objc func statesViewTapped() {
        viewModel.selectionAddressType = .state
        showSelectionPopUp()
    }
    
    @objc func districtViewTapped() {
        viewModel.selectionAddressType = .district
        showSelectionPopUp()
    }
    
    private func showSelectionPopUp() {
        nameView.resignFirstResponder()
        surnameView.resignFirstResponder()
        phoneNumberView.resignFirstResponder()
        userAddressView.resignFirstResponder()
        zipCodeView.resignFirstResponder()
        identityNumberContainer.resignFirstResponder()
        companyNameView.resignFirstResponder()
        taxNumberView.resignFirstResponder()
        taxOfficeView.resignFirstResponder()
        addressTitleView.resignFirstResponder()
        let selectionPopupVC = SRSelectionViewController(viewModel: viewModel.getSelectionModel())
        let navigationController = UINavigationController()
        selectionPopupVC.delegate = self
        navigationController.viewControllers = [selectionPopupVC]
        self.present(navigationController, animated: true)
    }
    
    private func getCountryList() {
        viewModel.getCountryModel(success: {
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func getStateList() {
        statesView.getTextField().isEnabled = true
        viewModel.getStateModel(success: {
            [weak self] in
            guard let self = self else { return }
            if self.viewModel.getStates().count != 0 {
                self.statesContainerView.isHidden = false
            } else {
                self.districtsContainerView.isHidden = true
                self.statesContainerView.isHidden = true
                self.districtView.getTextField().text = self.countryView.getTextField().text
                self.statesView.getTextField().text = self.countryView.getTextField().text
            }
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func getDistrictList() {
        districtView.getTextField().isEnabled = true
        viewModel.getDistrictModel(success: {
            [weak self] in
            
            if self?.viewModel.getDistricts().count != 0 {
                self?.districtsContainerView.isHidden = false
                if self?.viewModel.getDistricts().count == 1 {
                    self?.districtView.getTextField().text = self?.viewModel.getDistricts()[0].name
                    self?.districtView.getTextField().isEnabled = true
                }
            } else {
                self?.districtView.getTextField().text = self?.statesView.getTextField().text
                self?.districtsContainerView.isHidden = true
            }
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func isValid() -> Bool {
        var isValid : Bool = true
        if (nameView.getTextField().text == "") {
            setTextFieldError(textFieldView: nameView, errorMessage: ErrorConstants.nameEmptyError)
            isValid = false;
        } else if (nameView.getTextField().text?.count ?? 0 < 3) {
            setTextFieldError(textFieldView: nameView, errorMessage: ErrorConstants.nameValidationError)
            isValid = false;
        } else {
            nameView.getErrorLabelText() != nil ? nameView.setInfoLabel(infoText: "") : nameView.removeError()
        }
        if (surnameView.getTextField().text == "") {
            setTextFieldError(textFieldView: surnameView, errorMessage: ErrorConstants.surnameEmptyError)
            isValid = false
        } else if (surnameView.getTextField().text?.count ?? 0 < 3) {
            setTextFieldError(textFieldView: surnameView, errorMessage: ErrorConstants.surnameValidationError)
            isValid = false
        } else {
            surnameView.getErrorLabelText() != nil ? surnameView.setInfoLabel(infoText: "") : surnameView.removeError()
        }
        if (phoneNumberView.getTextField().text == "") {
            setTextFieldError(textFieldView: phoneNumberView, errorMessage: ErrorConstants.phoneEmptyError)
            isValid = false
        } else if (phoneNumberView.getTextField().text?.count ?? 0 < 11) {
            setTextFieldError(textFieldView: phoneNumberView, errorMessage: ErrorConstants.phoneValidationError)
            isValid = false
        } else {
            phoneNumberView.removeError()
        }
        if ((countryView.getTextField().text == "" && countryView.getTextField().placeholder != "") && !viewModel.isEditAvailable()) {
            setTextFieldError(textFieldView: countryView, errorMessage: ErrorConstants.countryError)
            isValid = false
        } else {
            countryView.removeError()
        }
        if (statesContainerView.isHidden == false) {
            if((statesView.getTextField().text == "" && statesView.getTextField().placeholder != "") && !viewModel.isEditAvailable()) {
                setTextFieldError(textFieldView: statesView, errorMessage: ErrorConstants.stateError)
                isValid = false
            } else {
                statesView.removeError()
            }
        }
        if (districtsContainerView.isHidden == false) {
            if((districtView.getTextField().text == "" && districtView.getTextField().placeholder != "") && !viewModel.isEditAvailable()) {
                setTextFieldError(textFieldView: districtView, errorMessage: ErrorConstants.districtError)
                isValid = false
            } else {
                districtView.removeError()
            }
        }
        if (userAddressView.getTextField().text == "") {
            setTextFieldError(textFieldView: userAddressView, errorMessage: ErrorConstants.addressEmptyError)
            isValid = false
        } else if (userAddressView.getTextField().text?.count ?? 0 < 3) {
            setTextFieldError(textFieldView: userAddressView, errorMessage: ErrorConstants.addressValidationError)
            isValid = false
        } else {
            userAddressView.removeError()
        }
        
        if (zipCodeView.getTextField().text == "") {
            setTextFieldError(textFieldView: zipCodeView, errorMessage: ErrorConstants.zipCodeEmptyError)
            isValid = false
        } else if (zipCodeView.getTextField().text?.count ?? 0 < 3) {
            setTextFieldError(textFieldView: zipCodeView, errorMessage: ErrorConstants.zipCodeValidationError)
            isValid = false
        } else {
            zipCodeView.getErrorLabelText() != nil ? zipCodeView.setInfoLabel(infoText: "") : zipCodeView.removeError()
        }
        if (addressTitleView.getTextField().text == "") {
            setTextFieldError(textFieldView: addressTitleView, errorMessage: ErrorConstants.addressTitleEmptyError)
            isValid = false
        } else if (addressTitleView.getTextField().text?.count ?? 0 < 2) {
            setTextFieldError(textFieldView: addressTitleView, errorMessage: ErrorConstants.addressTitleValidationError)
            isValid = false
        } else {
            addressTitleView.getErrorLabelText() != nil ? addressTitleView.setInfoLabel(infoText: "") : addressTitleView.removeError()
        }
        
        if (viewModel.isEditAvailable() && viewModel.getShippingAddress() != nil) {
            return isValid
        }
        if (viewModel.getAddressType() == .shipping && !isBillingAddressChecked) {
            return isValid
        }
        return isValid
    }
    
    private func setTextFieldError(textFieldView: SRTextField,errorMessage: String) {
        textFieldView.setError(errorMessage: errorMessage)
        textFieldView.getTextField().becomeFirstResponder()
    }
    
    private func editAddress() {
        switch viewModel.getAddressType() {
        case .billing:
            if let userBillingAddress = viewModel.getBillingAddress() {
                var editBillingAddress: EditAddressModel? = EditAddressModel()
                editBillingAddress?.apiKey = SRAppContext.appUserApiKey
                editBillingAddress?.appKey = SRAppContext.appUserAppKey
                editBillingAddress?.addressLine = userAddressView.getTextField().text
                editBillingAddress?.country = countryView.getTextField().text
                editBillingAddress?.state = statesView.getTextField().text
                editBillingAddress?.city = districtView.getTextField().text
                editBillingAddress?.phone = phoneNumberView.getTextField().text
                editBillingAddress?.zipCode = zipCodeView.getTextField().text
                editBillingAddress?.title = addressTitleView.getTextField().text
                editBillingAddress?.nameSurname = (nameView.getTextField().text ?? "") + " " + (surnameView.getTextField().text ?? "")
                editBillingAddress?.id = userBillingAddress.id
                if isIndividualButtonTapped {
                    editBillingAddress?.type = SRAppConstants.AddressType.Individual
                    editBillingAddress?.identityNumber = identityNumberView.getTextField().text
                }else {
                    editBillingAddress?.type = SRAppConstants.AddressType.Corporate
                    editBillingAddress?.companyName = companyNameView.getTextField().text
                    editBillingAddress?.taxNumber = taxNumberView.getTextField().text
                    editBillingAddress?.taxOffice = taxOfficeView.getTextField().text
                }
                viewModel.editAddressModel = editBillingAddress ?? EditAddressModel()
                saveBillingAddress(isEditing: true)
            }
            
        case .shipping:
            if let userShippingAddress = viewModel.getShippingAddress() {
                var editShippingAddress: EditAddressModel? = EditAddressModel()
                editShippingAddress?.apiKey = SRAppContext.appUserApiKey
                editShippingAddress?.appKey = SRAppContext.appUserAppKey
                editShippingAddress?.addressLine = userAddressView.getTextField().text
                editShippingAddress?.country = countryView.getTextField().text
                editShippingAddress?.state = statesView.getTextField().text
                editShippingAddress?.city = districtView.getTextField().text
                editShippingAddress?.phone = phoneNumberView.getTextField().text
                editShippingAddress?.zipCode = zipCodeView.getTextField().text
                editShippingAddress?.title = addressTitleView.getTextField().text
                editShippingAddress?.nameSurname = (nameView.getTextField().text ?? "") + " " + (surnameView.getTextField().text ?? "")
                editShippingAddress?.id = userShippingAddress.id
                if isIndividualButtonTapped {
                    editShippingAddress?.type = SRAppConstants.AddressType.Individual
                    editShippingAddress?.identityNumber = identityNumberView.getTextField().text
                }else {
                    editShippingAddress?.type = SRAppConstants.AddressType.Corporate
                    editShippingAddress?.companyName = companyNameView.getTextField().text
                    editShippingAddress?.taxNumber = taxNumberView.getTextField().text
                    editShippingAddress?.taxOffice = taxOfficeView.getTextField().text
                }
                viewModel.editAddressModel = editShippingAddress ?? EditAddressModel()
                saveShippingAddress(isEditing: true)
            }
        }
    }
    
    private func setEditBinds() {
        switch viewModel.getAddressType() {
        case .shipping:
            if let userShippingAddress = viewModel.getShippingAddress() {
                saveAsBillingContainer.isHidden = true
                billingAddressContainer.isHidden = true
                let names : [String] = userShippingAddress.contact?.nameSurname?.components(separatedBy: " ") ?? []
                surnameView.getTextField().text = names[names.count - 1]
                for i in 0..<(names.count - 1) {
                    if i == 0 {
                        nameView.getTextField().text = names[0]
                    } else {
                        nameView.getTextField().text = nameView.getTextField().text ?? "" + names[i]
                    }
                }
                phoneNumberView.getTextField().text = userShippingAddress.contact?.phoneNumber
                userAddressView.getTextField().text = userShippingAddress.addressLine
                countryView.getTextField().text = userShippingAddress.country
                districtView.getTextField().text = userShippingAddress.city
                statesView.getTextField().text = userShippingAddress.state
                zipCodeView.getTextField().text = userShippingAddress.zipCode
                addressTitleView.getTextField().text = userShippingAddress.title
            }
            
        case .billing:
            if let userBillingAddress = viewModel.getBillingAddress() {
                saveAsBillingContainer.isHidden = true
                billingAddressContainer.isHidden = false
                let names : [String] = userBillingAddress.contact?.nameSurname?.components(separatedBy: " ") ?? []
                surnameView.getTextField().text = names[names.count - 1]
                for i in 0..<(names.count - 1) {
                    if i == 0 {
                        nameView.getTextField().text = names[0]
                    }else {
                        nameView.getTextField().text = nameView.getTextField().text ?? "" + names[i]
                    }
                }
                phoneNumberView.getTextField().text = userBillingAddress.contact?.phoneNumber
                userAddressView.getTextField().text = userBillingAddress.addressLine
                countryView.getTextField().text = userBillingAddress.country
                districtView.getTextField().text = userBillingAddress.city
                statesView.getTextField().text = userBillingAddress.state
                zipCodeView.getTextField().text = userBillingAddress.zipCode
                addressTitleView.getTextField().text = userBillingAddress.title
                if userBillingAddress.type != nil && userBillingAddress.type == SRAppConstants.AddressType.Corporate {
                    isIndividualButtonTapped = false
                    companyNameView.getTextField().text = userBillingAddress.companyName
                    taxOfficeView.getTextField().text = userBillingAddress.taxOffice
                    taxNumberView.getTextField().text = userBillingAddress.taxNumber
                }
                else {
                    self.isIndividualButtonTapped = true
                    identityNumberView.getTextField().text = userBillingAddress.identityNumber
                }
            }
        }
        districtView.getTextField().isEnabled = false
        statesView.getTextField().isEnabled = false
    }
    
    private func saveAddress() {
        switch viewModel.getAddressType() {
        case .shipping:
            viewModel.addAddressModel.apiKey = SRAppContext.appUserApiKey
            viewModel.addAddressModel.appKey = SRAppContext.appUserAppKey
            viewModel.addAddressModel.addressLine = userAddressView.getTextField().text
            viewModel.addAddressModel.country = countryView.getTextField().text
            viewModel.addAddressModel.state = statesView.getTextField().text
            viewModel.addAddressModel.city = districtView.getTextField().text
            viewModel.addAddressModel.phone = phoneNumberView.getTextField().text
            viewModel.addAddressModel.zipCode = zipCodeView.getTextField().text
            viewModel.addAddressModel.title = addressTitleView.getTextField().text
            viewModel.addAddressModel.nameSurname = (nameView.getTextField().text ?? "") + " " + (surnameView.getTextField().text ?? "")
            viewModel.addAddressModel.addBoth = isBillingAddressChecked
            if isIndividualButtonTapped {
                viewModel.addAddressModel.type = SRAppConstants.AddressType.Individual
                viewModel.addAddressModel.identityNumber = identityNumberView.getTextField().text
            }else {
                viewModel.addAddressModel.type = SRAppConstants.AddressType.Corporate
                viewModel.addAddressModel.companyName = companyNameView.getTextField().text
                viewModel.addAddressModel.taxNumber = taxNumberView.getTextField().text
                viewModel.addAddressModel.taxOffice = taxOfficeView.getTextField().text
            }
            if viewModel.addAddressModel.addBoth == true {
                addAddress()
            } else {
                saveShippingAddress(isEditing: false)
            }
        case .billing:
            viewModel.addAddressModel.apiKey = SRAppContext.appUserApiKey
            viewModel.addAddressModel.appKey = SRAppContext.appUserAppKey
            viewModel.addAddressModel.addressLine = userAddressView.getTextField().text
            viewModel.addAddressModel.city = districtView.getTextField().text
            viewModel.addAddressModel.country = countryView.getTextField().text
            viewModel.addAddressModel.state = statesView.getTextField().text
            viewModel.addAddressModel.zipCode = zipCodeView.getTextField().text
            viewModel.addAddressModel.phone = phoneNumberView.getTextField().text
            viewModel.addAddressModel.nameSurname = (nameView.getTextField().text ?? "") + " " + (surnameView.getTextField().text ?? "")
            viewModel.addAddressModel.title = addressTitleView.getTextField().text
            if isIndividualButtonTapped {
                viewModel.addAddressModel.type = SRAppConstants.AddressType.Individual
                viewModel.addAddressModel.identityNumber = identityNumberView.getTextField().text
            }else {
                viewModel.addAddressModel.type = SRAppConstants.AddressType.Corporate
                viewModel.addAddressModel.companyName = companyNameView.getTextField().text
                viewModel.addAddressModel.taxNumber = taxNumberView.getTextField().text
                viewModel.addAddressModel.taxOffice = taxOfficeView.getTextField().text
            }
            saveBillingAddress(isEditing: false)
        }
        
    }
    
    private func saveShippingAddress(isEditing: Bool) {
        if isEditing {
            viewModel.saveEdittedShippingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped(userShippingAddressModel: self.viewModel.getShippingAddress(), userBillingAddressModel: nil, defaultAddressModel: nil)
                self.pop(animated: true, completion: nil)
            }) { [weak self] (errorViewModel) in
                guard let self = self else { return }
                self.showAlertError(viewModel: errorViewModel)
            }
        } else {
            viewModel.addShippingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped(userShippingAddressModel: self.viewModel.getShippingAddress(), userBillingAddressModel: nil, defaultAddressModel: nil)
                self.pop(animated: true, completion: nil)
            }) { [weak self] (errorViewModel) in
                guard let self = self else { return }
                self.showAlertError(viewModel: errorViewModel)
            }
        }
        
        
    }
    
    private func saveBillingAddress(isEditing: Bool) {
        if isEditing {
            viewModel.saveEdittedBillingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped(userShippingAddressModel: nil, userBillingAddressModel: self.viewModel.getBillingAddress(), defaultAddressModel: nil)
                self.pop(animated: true, completion: nil)
            }) { [weak self] (errorViewModel) in
                guard let self = self else { return }
                self.showAlertError(viewModel: errorViewModel)
            }
        } else {
            viewModel.addBillingAddress(success: {
                [weak self] in
                guard let self = self else { return }
                
                self.delegate?.saveButtonTapped(userShippingAddressModel: nil, userBillingAddressModel: self.viewModel.getBillingAddress(), defaultAddressModel: nil)
                self.pop(animated: true, completion: nil)
            }) { [weak self] (errorViewModel) in
                guard let self = self else { return }
                self.showAlertError(viewModel: errorViewModel)
            }
        }
        
    }
    
    private func addAddress() {
        viewModel.addAddress(success: {
            [weak self] in
            guard let self = self else { return }
            
            self.delegate?.saveButtonTapped(userShippingAddressModel: nil, userBillingAddressModel: nil, defaultAddressModel: self.viewModel.getDefaultAddressModel())
            self.pop(animated: true, completion: nil)
        }) { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
        }
        
    }
}

extension SRAddressBottomSheetViewController : UITextFieldDelegate {
    
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
            districtViewTapped()
            return false
        }
        return true;
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameView.getTextField():
            surnameView.getTextField().becomeFirstResponder()
        case surnameView.getTextField():
            phoneNumberView.getTextField().becomeFirstResponder()
        case phoneNumberView.getTextField():
            self.countryViewTapped()
        case countryView.getTextField():
            self.statesViewTapped()
        case statesView.getTextField():
            self.districtViewTapped()
        case districtView.getTextField():
            userAddressView.getTextField().becomeFirstResponder()
        case userAddressView.getTextField():
            zipCodeView.getTextField().becomeFirstResponder()
        case zipCodeView.getTextField():
            addressTitleView.getTextField().becomeFirstResponder()
        case addressTitleView.getTextField():
            identityNumberView.getTextField().becomeFirstResponder()
        case companyNameView.getTextField():
            taxOfficeView.getTextField().becomeFirstResponder()
        case taxOfficeView.getTextField():
            taxNumberView.getTextField().becomeFirstResponder()
        default:
            break
        }
        return true
    }
}

extension SRAddressBottomSheetViewController: SelectionController {
    func getCountryId(id: String?) {
        switch viewModel.selectionAddressType {
        case .country:
            viewModel.countryId = id ?? ""
            countryView.getTextField().text = viewModel.getSelectedCountryName(selectedId: id)
            statesView.getTextField().text = nil
            statesView.isEnabled = viewModel.countryId != ""
            districtView.getTextField().text = nil
            getStateList()
        case .state:
            self.viewModel.stateId = id ?? ""
            districtView.getTextField().text = nil
            districtView.isEnabled = true
            statesView.getTextField().text = viewModel.getSelectedStateName(selectedId: id)
            getDistrictList()
        case .district:
            self.districtView.getTextField().text = viewModel.getSelectedCityName(selectedId: id)
        case .none:
            break
        }
    }
    
}


