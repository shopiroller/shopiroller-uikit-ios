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
    
    @IBOutlet weak var paymentTitle: UILabel!
    
    @IBOutlet private weak var addressDetailTable: UITableView!
    @IBOutlet private weak var productsTable: UITableView!
    
    @IBOutlet private weak var cargoSeparator: UIView!
    @IBOutlet private weak var cargoStackView: UIStackView!
    @IBOutlet private weak var paymentSeparator: UIView!
    @IBOutlet private weak var paymentStackView: UIStackView!
    @IBOutlet private weak var addressSeparator: UIView!
    @IBOutlet private weak var addressStackView: UIStackView!
    @IBOutlet private weak var productsSeparator: UIView!
    @IBOutlet private weak var productsStackView: UIView!
    
    
    init(viewModel: OrderDetailViewModel){
        super.init(viewModel: viewModel, nibName: OrderDetailViewController.nibName, bundle: Bundle(for: OrderDetailViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        orderDetailId.text = viewModel.getOrderCode()
        orderDetailPaymentStatus.text = viewModel.getCurrentStatus()
        orderDetailDate.text = viewModel.getCreatedDate()
        
        if(viewModel.isCargoTrackingAvailable()){
            cargoTrackingId.text = viewModel.getShippingTrackingCode()
            cargoTrackingName.text = viewModel.getShippingTrackingCompany()
        }else {
            cargoSeparator.isHidden = true
            cargoStackView.isHidden = true
        }
        
        if(viewModel.isPaymentTypeAvailable()){
            paymentTitle.text = viewModel.getPaymentMethodTitle()
            let labelArr = viewModel.getPaymentLabels()
            if(!labelArr.isEmpty){
                for label in labelArr {
                    paymentStackView.addArrangedSubview(label)
                }
            }
        }else {
            paymentSeparator.isHidden = true
            paymentStackView.isHidden = true
        }
        
        bottomSubTotal.text = viewModel.getSubTotalText()
        bottomShipping.text = viewModel.getShippingTotalText()
        bottomTotalPrice.text = viewModel.getTotalText()


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
