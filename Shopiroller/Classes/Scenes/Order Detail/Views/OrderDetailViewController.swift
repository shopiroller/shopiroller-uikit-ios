//
//  OrderDetailViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class OrderDetailViewController: BaseViewController<OrderDetailViewModel> {
    
    
    @IBOutlet private weak var bottomSubTotal: UILabel!
    @IBOutlet private weak var bottomShipping: UILabel!
    @IBOutlet private weak var bottomTotal: UILabel!
    @IBOutlet private weak var bottomTotalPrice: UILabel!
    
    @IBOutlet private weak var orderDetailId: UILabel!
    @IBOutlet private weak var orderDetailPaymentStatus: UILabel!
    @IBOutlet private weak var orderDetailDate: UILabel!
    @IBOutlet private weak var orderDetailStatusImage: UIImageView!
    
    @IBOutlet private weak var cargoTrackingName: UILabel!
    @IBOutlet private weak var cargoTrackingId: UILabel!
    
    @IBOutlet private weak var paymentTransfer: UILabel!
    @IBOutlet private weak var paymentBank: UILabel!
    @IBOutlet private weak var paymentBankOwner: UILabel!
    @IBOutlet private weak var paymentAccount: UILabel!
    @IBOutlet private weak var paymentIban: UILabel!
    
    @IBOutlet private weak var addressDetailTable: UITableView!
    @IBOutlet private weak var productsTable: UITableView!
    
    
    init(viewModel: OrderDetailViewModel){
        super.init(viewModel: viewModel, nibName: OrderDetailViewController.nibName, bundle: Bundle(for: OrderDetailViewController.self))
    }
    
    override func setup() {
        super.setup()
        
    
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
