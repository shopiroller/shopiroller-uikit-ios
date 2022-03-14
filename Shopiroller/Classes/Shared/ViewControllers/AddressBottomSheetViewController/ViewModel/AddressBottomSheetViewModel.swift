//
//  AddressBottomSheetViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation


class AddressBottomSheetViewModel : SRBaseViewModel {
    
    private var type: GeneralAddressType
    private var isEditing: Bool
    
    var selectionType: SelectionType?
    
    private var countryList: [CountryModel]?
    private var stateList: [CountryModel]?
    private var districtList: [CountryModel]?
    private var _countryId = String()
    private var _stateId = String()
    
    
    private var userShippingAddress: UserShippingAddressModel?
    private var userBillingAddress: UserBillingAdressModel?
    private var defaultAddressModel: SRDefaultAddressModel?
    
    var addAddressModel: AddAddressModel = AddAddressModel()
    var editAddressModel: EditAddressModel = EditAddressModel()
    
    init(type: GeneralAddressType , isEditing: Bool = false, userShippingAddress : UserShippingAddressModel? = nil , userBillingAddress: UserBillingAdressModel? = nil){
        self.type = type
        self.isEditing = isEditing
        self.userShippingAddress = userShippingAddress
        self.userBillingAddress = userBillingAddress
    }
    
    func getAddressType() -> GeneralAddressType {
        return type
    }
    
    func isEditAvailable() -> Bool {
        return isEditing
    }
    
    func addShippingAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        
        SRNetworkManagerRequests.addShippingAddress(addAddressModel, userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.userShippingAddress = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func addBillingAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.addBillingAddress(addAddressModel, userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.userBillingAddress = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func addAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.addAddress(userId: SRAppContext.userId, address: addAddressModel).response() {
            (result) in
            switch result {
            case .success(let response):
                self.defaultAddressModel = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getCountryModel(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getCountryList().response() {
            (result) in
            switch result {
            case .success(let response):
                self.countryList = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getStateModel(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.countryId, value: String(countryId)))
        SRNetworkManagerRequests.getStateList(urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result {
            case .success(let response):
                self.stateList = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getDistrictModel(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.stateId, value: String(stateId)))
        SRNetworkManagerRequests.getDistrictList(urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result {
            case .success(let response):
                self.districtList = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func saveEdittedShippingAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.editShippingAddress(editAddressModel, userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.userShippingAddress = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func saveEdittedBillingAddress(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.editBillingAddress(editAddressModel, userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let response):
                self.userBillingAddress = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getBillingAddress() -> UserBillingAdressModel? {
        return userBillingAddress
    }
    
    func getShippingAddress() -> UserShippingAddressModel? {
        return userShippingAddress
    }
    
    func getDefaultAddressModel() -> SRDefaultAddressModel? {
        return defaultAddressModel
    }
    
    func getCountries() -> [CountryModel] {
        return countryList ?? []
    }
    
    func getStates() -> [CountryModel] {
        return stateList ?? []
    }
    
    func getDistricts() -> [CountryModel] {
        return districtList ?? []
    }
    
    func getSelectionModel() -> SelectionPopUpViewModel {
        switch selectionType {
        case .country:
            return SelectionPopUpViewModel(selectionPopUpModel: SelectionPopUpModel(datalist: getCountries(), selectionType: .country))
        case .district:
            return SelectionPopUpViewModel(selectionPopUpModel: SelectionPopUpModel(datalist: getDistricts(), selectionType: .district))
        case .state:
            return SelectionPopUpViewModel(selectionPopUpModel: SelectionPopUpModel(datalist: getStates(), selectionType: .state))
        case .none:
            return SelectionPopUpViewModel(selectionPopUpModel: SelectionPopUpModel(datalist: getCountries(), selectionType: .country))
        }
    }
    
    func getSelectedCountryName(selectedId : String?) -> String? {
        if let countryList = countryList {
            guard let selectedId = selectedId else { return nil }
            for state in countryList {
                if (state.id == selectedId) {
                    return state.name
                }
            }
        }
        return ""
    }
    
    func getSelectedCityName(selectedId : String?) -> String? {
        if let cityList = districtList {
            guard let selectedId = selectedId else { return nil }
            for state in cityList {
                if (state.id == selectedId) {
                    return state.name
                }
            }
        }
        return ""
    }
    
    func getSelectedStateName(selectedId : String?) -> String? {
        if let stateList = stateList {
            guard let selectedId = selectedId else { return nil }
            for state in stateList {
                if (state.id == selectedId) {
                    return state.name
                }
            }
        }
        return ""
    }
    
    var countryId: String {
        set {
            _countryId = newValue
        } get {
            return _countryId
        }
    }
    
    var stateId: String {
        set {
            _stateId = newValue
        } get {
            return _stateId
        }
    }
    
}
