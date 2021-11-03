//
//  CheckOutAddressViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

class CheckOutAddressViewController: BaseViewController<CheckOutAddressViewModel> {
    @IBOutlet private weak var shippingAddressEmptyView: EmptyView!
    @IBOutlet private weak var billingAddressEmptyView: EmptyView!
    
    
    override func setup() {
        super.setup()
    }
    
    init(viewModel: CheckOutAddressViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutAddressViewController.nibName, bundle: Bundle(for: CheckOutAddressViewController.self))
    }

}

extension CheckOutAddressViewController: GeneralAddressDelegate {
    func addAddressButtonTapped(type: GeneralAddressType?) {
        //TODO Add Address
    }
    
    func selectOtherAdressButtonTapped(type: GeneralAddressType?) {
        //TODO Select Other Adress
    }
    
    func editButtonTapped() {
        //TODO Edit Address
    }
    
    
}
