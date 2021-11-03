//
//  CheckOutInfoViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

class CheckOutInfoViewController: BaseViewController<CheckOutInfoViewModel> {
    
    init(viewModel: CheckOutInfoViewModel){
        super.init(viewModel: viewModel, nibName: CheckOutInfoViewController.nibName, bundle: Bundle(for: CheckOutInfoViewController.self))
    }
    
    override func setup() {
        super.setup()
    }
    

}
