//
//  OrderDetailViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class OrderDetailViewController: BaseViewController<OrderDetailViewModel> {
    
    @IBOutlet weak var root: UIStackView!
    
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
    
    @IBOutlet private weak var paymentTitle: UILabel!
    
    @IBOutlet private weak var productsDataStackView: UIStackView!
    @IBOutlet private weak var addressDataStackView: UIStackView!
    
    @IBOutlet private weak var cargoSeparator: UIView!
    @IBOutlet private weak var cargoStackView: UIStackView!
    @IBOutlet private weak var paymentSeparator: UIView!
    @IBOutlet private weak var paymentStackView: UIStackView!
    @IBOutlet private weak var addressSeparator: UIView!
    @IBOutlet private weak var addressStackView: UIStackView!
    @IBOutlet private weak var productsSeparator: UIView!
    @IBOutlet private weak var productsStackView: UIView!
    
    @IBOutlet private weak var addressHeight: NSLayoutConstraint!
    @IBOutlet private weak var productsHeight: NSLayoutConstraint!
    
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
        
        for item in viewModel.getAddressList() {
            let view = AddressView()
            view.setup(model: item)
            addressDataStackView.addArrangedSubview(view)
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 100),
                view.heightAnchor.constraint(equalToConstant: 100),
            ])
        }
       
        addressHeight.constant = 222
       
    
    }
    
}

