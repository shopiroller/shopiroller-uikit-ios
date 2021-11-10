//
//  AddressBottomSheetViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation


class AddressBottomSheetViewModel : BaseViewModel {
    
    private var type: GeneralAddressType
    private var isEditing: Bool
    
    var selectionType: SelectionType? = .country
    
    private var countryList: [CountryModel]?
    private var stateList: [CountryModel]?
    private var cityList: [CountryModel]?
    private var _countryId = String()
    private var _stateId = String()
    
    
    var userShippingAddress: UserShippingAddressModel?
    var userBillingAddress: UserBillingAdressModel?
    
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
        
        SRNetworkManagerRequests.addShippingAddress(addAddressModel,userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result {
            case .success(_):
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
        SRNetworkManagerRequests.addBillingAddress(addAddressModel,userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result {
            case .success(_):
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
        SRNetworkManagerRequests.addAddress(userId: SRAppConstants.Query.Values.userId, address: addAddressModel).response() {
            (result) in
            switch result {
            case .success(_):
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
    
    func getCityModel(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.stateId, value: String(stateId)))
        SRNetworkManagerRequests.getCityList(urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result {
            case .success(let response):
                self.cityList = response.data
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
        SRNetworkManagerRequests.editShippingAddress(editAddressModel, userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result {
            case .success(_):
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
        SRNetworkManagerRequests.editBillingAddress(editAddressModel, userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result {
            case .success(_):
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
    
    func getCountries() -> [CountryModel] {
        return countryList ?? []
    }
    
    func getStates() -> [CountryModel] {
        return stateList ?? []
    }
    
    func getCities() -> [CountryModel] {
        return cityList ?? []
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

enum SelectionType {
    case country
    case state
    case city
}
