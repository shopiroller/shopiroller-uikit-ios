//
//  CheckOutPaymentViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

class CheckOutPaymentViewController: BaseViewController<CheckOutPaymentViewModel> {

    override func setup() {
        super.setup()
        view.backgroundColor = .red
    }
    
    init(viewModel: CheckOutPaymentViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutPaymentViewController.nibName, bundle: Bundle(for:  CheckOutPaymentViewController.self))
    }
    
}
