//
//  AddressBottomSheetViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation

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
        
        static var citiesTextFieldText: String { return "address-bottom-view-cities-text".localized }
        
    }
    
    @IBOutlet private weak var topViewContainer: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var countryTextField: UITextField!
    @IBOutlet private weak var dropdownImage: UIImageView!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var zipCodeTextField: UITextField!
    @IBOutlet private weak var addressTitleTextField: UITextField!
    @IBOutlet private weak var individualCheckBoxButton: UIButton!
    @IBOutlet private weak var individualCheckBoxTitle: UILabel!
    @IBOutlet private weak var corporateCheckBoxButton: UIButton!
    @IBOutlet private weak var corporateCheckBoxTitle: UILabel!
    @IBOutlet private weak var identityNumberContainer: UIView!
    @IBOutlet private weak var identityNumberTextField: UITextField!
    @IBOutlet private weak var corporateContainer: UIView!
    @IBOutlet private weak var companyNameTextField: UITextField!
    @IBOutlet private weak var taxOfficeTextField: UITextField!
    @IBOutlet private weak var taxNumberTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var billingAddressContainer: UIView!
    @IBOutlet private weak var saveAsBillingAddressButton: UIButton!
    @IBOutlet private weak var saveAsBillingAddressTitle: UILabel!
    @IBOutlet private weak var saveAsBillingContainer: UIView!
    @IBOutlet private weak var statesContainerView: UIView!
    @IBOutlet private weak var citiesContainerView: UIView!
    @IBOutlet private weak var statesTextField: UITextField!
    @IBOutlet private weak var statesDropDownImage: UIImageView!
    @IBOutlet private weak var citiesTextField: UITextField!
    @IBOutlet private weak var citiesDropDownImage: UIImageView!
    
    
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
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        saveAsBillingAddressButton.setImage(UIImage(systemName: "checkmark.circle"))
        saveAsBillingAddressButton.imageView?.tintColor = .black
        
        individualCheckBoxButton.setImage(.radioOn)
        individualCheckBoxTitle.text = Constants.individualTextFieldText
        corporateCheckBoxTitle.text = Constants.corporateCheckBoxText
        corporateCheckBoxButton.setImage(.radioOff)
        
        saveAsBillingAddressTitle.text = Constants.saveAsBillingAddressText
        saveAsBillingAddressTitle.textColor = .black
        saveAsBillingAddressTitle.font = UIFont.systemFont(ofSize: 14)
        
        saveButton.setTitle(Constants.saveButtonText)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        saveButton.backgroundColor = .black
        saveButton.tintColor = .white
        
        nameTextField.placeholder = Constants.nameTextFieldText
        surnameTextField.placeholder = Constants.surNameTextFieldText
        phoneNumberTextField.placeholder = Constants.phoneTextFieldText
        countryTextField.placeholder = Constants.countryTextFieldText
        statesTextField.placeholder = Constants.statesTextFieldText
        citiesTextField.placeholder = Constants.citiesTextFieldText
        addressTextField.placeholder = Constants.addressTextFieldText
        zipCodeTextField.placeholder = Constants.zipCodeTextFieldText
        addressTitleTextField.placeholder = Constants.addressTitleTextFieldText
        identityNumberTextField.placeholder = Constants.identityNumberTextFieldText
        companyNameTextField.placeholder = Constants.companyNameTextFieldText
        taxOfficeTextField.placeholder = Constants.corporateTaxOfficeTextFieldText
        taxNumberTextField.placeholder = Constants.corporateTaxNumberTextFieldText
        
        let tapCountryTextField = UITapGestureRecognizer(target: self, action: #selector(countryViewTapped))
        countryTextField.backgroundColor = .clear
        countryTextField.isUserInteractionEnabled = true
        countryTextField.addGestureRecognizer(tapCountryTextField)
        
        let tapStatesTextField = UITapGestureRecognizer(target: self, action: #selector(statesViewTapped))
        statesTextField.backgroundColor = .clear
        statesTextField.isUserInteractionEnabled = true
        statesTextField.addGestureRecognizer(tapStatesTextField)
        
        let tapCitiesTextField = UITapGestureRecognizer(target: self, action: #selector(citiesViewTapped))
        citiesTextField.backgroundColor = .clear
        citiesTextField.isUserInteractionEnabled = true
        citiesTextField.addGestureRecognizer(tapCitiesTextField)
        
        topViewContainer.backgroundColor = .iceBlue
        
        getCountryList()
        setUpLayout()
        if viewModel.isEditAvailable() {
            setEditBinds()
            statesContainerView.isHidden = false
            citiesContainerView.isHidden = false
        }
        
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
        self.viewModel.selectionType = .country
        statesTextField.isEnabled = true
        statesTextField.text = ""
        citiesContainerView.isHidden = true
        let vc = SelectionPopUpViewController(viewModel: SelectionPopUpViewModel(selectionList: viewModel.getCountries(), type: .country))
        vc.delegate = self
        popUp(vc)
    }
    
    @objc func statesViewTapped() {
        self.viewModel.selectionType = .state
        citiesTextField.isEnabled = true
        citiesTextField.text = ""
        let vc = SelectionPopUpViewController(viewModel: SelectionPopUpViewModel(selectionList: viewModel.getStates(), type: .state))
        vc.delegate = self
        popUp(vc)
    }
    
    @objc func citiesViewTapped() {
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
                    self?.citiesTextField.text = self?.viewModel.getCities()[0].name
                    self?.citiesTextField.isEnabled = true
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
        if (nameTextField.text == "") {
            nameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false;
        } else if (nameTextField.text?.count ?? 0 < 3) {
            nameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false;
        }
        if (surnameTextField.text == "") {
            surnameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        } else if (surnameTextField.text?.count ?? 0 < 3) {
            surnameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        }
        if (phoneNumberTextField.text == "") {
            phoneNumberTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        } else if (phoneNumberTextField.text?.count ?? 0 < 11) {
            phoneNumberTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        }
        if (countryTextField.text == "") {
            countryTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        }
        if (statesTextField.isHidden == true) {
            if(statesTextField.text == "" && statesTextField.placeholder == "") {
                statesTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                isValid = false
            }
        }
        if (citiesTextField.isHidden == false) {
            if(citiesTextField.text == "" && citiesTextField.placeholder == "") {
                citiesTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                isValid = false
            }
        }
        if (addressTextField.text == "") {
            addressTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        } else if (addressTextField.text?.count ?? 0 < 3) {
            addressTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        }
        if (zipCodeTextField.text == "") {
            zipCodeTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        } else if (zipCodeTextField.text?.count ?? 0 < 3) {
            zipCodeTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        }
        if (addressTitleTextField.text == "") {
            addressTitleTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        } else if (addressTitleTextField.text?.count ?? 0 < 2) {
            addressTitleTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            isValid = false
        }
        
        if (viewModel.isEditAvailable() && viewModel.userShippingAddress != nil) {
            return isValid
        }
        if (viewModel.getAddressType() == .shipping && !isBillingAddressChecked) {
            return isValid
        }
        
        if billingAddressContainer.isHidden == false {
            if isIndividualButtonTapped {
                if (identityNumberTextField.text == "") {
                    identityNumberTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                    isValid = false;
                } else if (identityNumberTextField.text?.count ?? 0 < 11) {
                    identityNumberTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                    isValid = false;
                }
            }else {
                if (companyNameTextField.text == "") {
                    companyNameTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                    isValid = false;
                }
                if (taxOfficeTextField.text == "") {
                    taxOfficeTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                    isValid = false;
                }
                if (taxNumberTextField.text == "") {
                    taxNumberTextField.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
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
                editBillingAddress?.addressLine = addressTextField.text
                editBillingAddress?.country = countryTextField.text
                editBillingAddress?.state = statesTextField.placeholder
                editBillingAddress?.city = citiesTextField.placeholder
                editBillingAddress?.phone = phoneNumberTextField.text
                editBillingAddress?.zipCode = zipCodeTextField.text
                editBillingAddress?.title = addressTitleTextField.text
                editBillingAddress?.nameSurname = (nameTextField.text ?? "") + " " + (surnameTextField.text ?? "")
                editBillingAddress?.id = userBillingAddress.id
                if isIndividualButtonTapped {
                    editBillingAddress?.type = "Individual"
                    editBillingAddress?.identityNumber = identityNumberTextField.text
                }else {
                    editBillingAddress?.type = "Corporate"
                    editBillingAddress?.companyName = companyNameTextField.text
                    editBillingAddress?.taxNumber = taxNumberTextField.text
                    editBillingAddress?.taxOffice = taxOfficeTextField.text
                }
                viewModel.editAddressModel = editBillingAddress ?? EditAddressModel()
                saveBillingAddress(isEditing: true)
            }
            
        case .shipping:
            if let userShippingAddress = viewModel.getShippingAddress() {
                var editShippingAddress: EditAddressModel? = EditAddressModel()
                editShippingAddress?.apiKey = SRNetworkContext.apiKey
                editShippingAddress?.appKey = SRNetworkContext.appKey
                editShippingAddress?.addressLine = addressTextField.text
                editShippingAddress?.country = countryTextField.text
                editShippingAddress?.state = statesTextField.placeholder
                editShippingAddress?.city = citiesTextField.placeholder
                editShippingAddress?.phone = phoneNumberTextField.text
                editShippingAddress?.zipCode = zipCodeTextField.text
                editShippingAddress?.title = addressTitleTextField.text
                editShippingAddress?.nameSurname = (nameTextField.text ?? "") + " " + (surnameTextField.text ?? "")
                editShippingAddress?.id = userShippingAddress.id
                if isIndividualButtonTapped {
                    editShippingAddress?.type = "Individual"
                    editShippingAddress?.identityNumber = identityNumberTextField.text
                }else {
                    editShippingAddress?.type = "Corporate"
                    editShippingAddress?.companyName = companyNameTextField.text
                    editShippingAddress?.taxNumber = taxNumberTextField.text
                    editShippingAddress?.taxOffice = taxOfficeTextField.text
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
                surnameTextField.text = names[names.count - 1]
                for i in 0..<(names.count - 1){
                    if i == 0 {
                        nameTextField.text = names[0]
                    }else {
                        nameTextField.text = nameTextField.text ?? "" + names[i]
                    }
                }
                phoneNumberTextField.text = userShippingAddress.contact?.phoneNumber
                addressTextField.text = userShippingAddress.addressLine
                countryTextField.text = userShippingAddress.country
                citiesTextField.placeholder = userShippingAddress.city
                statesTextField.placeholder = userShippingAddress.state
                zipCodeTextField.text = userShippingAddress.zipCode
                addressTitleTextField.text = userShippingAddress.title
            }
            
        case .billing:
            if let userBillingAddress = viewModel.getBillingAddress() {
                saveAsBillingContainer.isHidden = true
                billingAddressContainer.isHidden = false
                let names : [String] = userBillingAddress.contact?.nameSurname?.components(separatedBy: " ") ?? []
                surnameTextField.text = names[names.count - 1]
                for i in 0..<(names.count - 1){
                    if i == 0 {
                        nameTextField.text = names[0]
                    }else {
                        nameTextField.text = nameTextField.text ?? "" + names[i]
                    }
                }
                phoneNumberTextField.text = userBillingAddress.contact?.phoneNumber
                addressTextField.text = userBillingAddress.addressLine
                countryTextField.text = userBillingAddress.country
                citiesTextField.placeholder = userBillingAddress.city
                statesTextField.placeholder = userBillingAddress.state
                zipCodeTextField.text = userBillingAddress.zipCode
                addressTitleTextField.text = userBillingAddress.title
                if userBillingAddress.type != nil && userBillingAddress.type?.lowercased() == "corporate"{
                    isIndividualButtonTapped = false
                    companyNameTextField.text = userBillingAddress.companyName
                    taxOfficeTextField.text = userBillingAddress.taxOffice
                    taxNumberTextField.text = userBillingAddress.taxNumber
                }
                else {
                    self.isIndividualButtonTapped = true
                    identityNumberTextField.text = userBillingAddress.identityNumber
                }
            }
        }
        citiesTextField.isEnabled = false
        statesTextField.isEnabled = false
    }
    
    private func saveAddress() {
        switch viewModel.getAddressType() {
        case .shipping:
            var addShippingAddress : AddAddressModel? = AddAddressModel()
            addShippingAddress?.apiKey = SRNetworkContext.apiKey
            addShippingAddress?.appKey = SRNetworkContext.appKey
            addShippingAddress?.addressLine = addressTextField.text
            addShippingAddress?.country = countryTextField.text
            addShippingAddress?.state = statesTextField.text
            addShippingAddress?.city = citiesTextField.text
            addShippingAddress?.phone = phoneNumberTextField.text
            addShippingAddress?.zipCode = zipCodeTextField.text
            addShippingAddress?.title = addressTitleTextField.text
            addShippingAddress?.nameSurname = (nameTextField.text ?? "") + " " + (surnameTextField.text ?? "")
            addShippingAddress?.addBoth = isBillingAddressChecked
            if isIndividualButtonTapped {
                addShippingAddress?.type = "Individual"
                addShippingAddress?.identityNumber = identityNumberTextField.text
            }else {
                addShippingAddress?.type = "Corporate"
                addShippingAddress?.companyName = companyNameTextField.text
                addShippingAddress?.taxNumber = taxNumberTextField.text
                addShippingAddress?.taxOffice = taxOfficeTextField.text
            }
            viewModel.addAddressModel = addShippingAddress ?? AddAddressModel()
            if addShippingAddress?.addBoth == true {
                addAddress()
            } else {
                saveShippingAddress(isEditing: false)
            }
        case .billing:
            var addBillingAddress : AddAddressModel? = AddAddressModel()
            addBillingAddress?.apiKey = SRNetworkContext.apiKey
            addBillingAddress?.appKey = SRNetworkContext.appKey
            addBillingAddress?.addressLine = addressTextField.text
            addBillingAddress?.city = citiesTextField.text
            addBillingAddress?.country = countryTextField.text
            addBillingAddress?.state = statesTextField.text
            addBillingAddress?.zipCode = zipCodeTextField.text
            addBillingAddress?.phone = phoneNumberTextField.text
            addBillingAddress?.nameSurname = (nameTextField.text ?? "") + " " + (surnameTextField.text ?? "")
            addBillingAddress?.title = addressTitleTextField.text
            if isIndividualButtonTapped {
                addBillingAddress?.type = "Individual"
                addBillingAddress?.identityNumber = identityNumberTextField.text
            }else {
                addBillingAddress?.type = "Corporate"
                addBillingAddress?.companyName = companyNameTextField.text
                addBillingAddress?.taxNumber = taxNumberTextField.text
                addBillingAddress?.taxOffice = taxOfficeTextField.text
            }
            viewModel.addAddressModel = addBillingAddress ?? AddAddressModel()
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


extension AddressBottomSheetViewController: SelectionPopoUpDelegate {
    func getCountryId(id: String?, type: SelectionType?) {
        switch type {
        case .country:
            self.viewModel.countryId = id ?? ""
            getStateList()
        case .state:
            self.viewModel.stateId = id ?? ""
            getCitiesList()
        case .city:
            break
        case .none:
            break
        }
    }
    
    func getCountryName(name: String?, type: SelectionType?) {
        switch type {
        case .country:
            countryTextField.text = name
        case .city:
            citiesTextField.text = name
        case .state:
            statesTextField.text = name
        case .none:
            break
        }
    }   
    
}

