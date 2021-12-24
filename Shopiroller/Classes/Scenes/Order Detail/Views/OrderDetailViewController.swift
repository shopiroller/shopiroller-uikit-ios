//
//  OrderDetailViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class OrderDetailViewController: BaseViewController<OrderDetailViewModel> {
    
    
    @IBOutlet weak var bottomPriceView: BottomPriceView!
    
    @IBOutlet private weak var orderDetailTitleLabel: UILabel!
    @IBOutlet private weak var orderDetailId: UILabel!
    @IBOutlet private weak var orderDetailPaymentStatus: UILabel!
    @IBOutlet private weak var orderDetailDate: UILabel!
    @IBOutlet private weak var orderDetailStatusImage: UIImageView!
    
    @IBOutlet private weak var cargoTrackingTitleLabel: UILabel!
    @IBOutlet private weak var cargoTrackingName: UILabel!
    @IBOutlet private weak var cargoTrackingId: UILabel!
    
    @IBOutlet private weak var paymentTitleLabel: UILabel!
    @IBOutlet private weak var paymentTitle: UILabel!
    
    @IBOutlet private weak var addressDataStackView: UIStackView!
    @IBOutlet private weak var productsDataStackView: UIStackView!
    
    @IBOutlet private weak var cargoSeparator: UIView!
    @IBOutlet private weak var cargoStackView: UIStackView!
    @IBOutlet private weak var paymentSeparator: UIView!
    @IBOutlet private weak var paymentStackView: UIStackView!
    @IBOutlet private weak var addressSeparator: UIView!
    @IBOutlet private weak var addressDetailTitleLabel: UILabel!
    @IBOutlet private weak var addressStackView: UIStackView!
    @IBOutlet private weak var productsSeparator: UIView!
    @IBOutlet private weak var productsTitleLabel: UILabel!
    @IBOutlet private weak var productsStackView: UIStackView!
    
    @IBOutlet private weak var addressHeight: NSLayoutConstraint!
    @IBOutlet private weak var productsHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var userShippingAddressView: AddressView!
    @IBOutlet private weak var userBillingAddressView: AddressView!
    
    
    init(viewModel: OrderDetailViewModel){
        super.init("order-detail-page-title".localized, viewModel: viewModel, nibName: OrderDetailViewController.nibName, bundle: Bundle(for: OrderDetailViewController.self))
    }
    
    override func setup() {
        super.setup()
        getCount()
        orderDetailStatusImage.image = viewModel.getStatusImage()
        
        orderDetailTitleLabel.textColor = .textPrimary
        orderDetailTitleLabel.font = .bold18
        
        cargoTrackingTitleLabel.textColor = .textPrimary
        cargoTrackingTitleLabel.font = .bold18
        
        addressDetailTitleLabel.textColor = .textPrimary
        addressDetailTitleLabel.font = .bold18
        
        productsTitleLabel.textColor = .textPrimary
        productsTitleLabel.font = .bold18
        
        orderDetailId.textColor = .textPCaption
        orderDetailId.font = .regular12
        
        orderDetailPaymentStatus.textColor = .textPCaption
        orderDetailPaymentStatus.font = .regular12
        
        orderDetailDate.textColor = .textPCaption
        orderDetailDate.font = .regular12
        
        orderDetailId.text = viewModel.getOrderCode()
        orderDetailPaymentStatus.text = viewModel.getCurrentStatus()
        orderDetailDate.text = viewModel.getCreatedDate()
        
        if(viewModel.isCargoTrackingAvailable()){
            cargoTrackingId.textColor = .textPCaption
            cargoTrackingId.font = .regular12
            cargoTrackingName.textColor = .textPCaption
            cargoTrackingName.font = .regular12
            cargoTrackingId.text = viewModel.getShippingTrackingCode()
            cargoTrackingName.text = viewModel.getShippingTrackingCompany()
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(OrderDetailViewController.onClickCargoText))
            cargoTrackingId.addGestureRecognizer(tap)
            
        }else {
            cargoSeparator.isHidden = true
            cargoStackView.isHidden = true
        }
        
        if(viewModel.isPaymentTypeAvailable()){
            paymentTitle.textColor = .textPCaption
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
        
        bottomPriceView.setup(model: viewModel.getBottomPriceModel())
      
        userShippingAddressView.configure(model: viewModel.getUserShippingAddressModel())
        userBillingAddressView.configure(model: viewModel.getUserBillingAddressModel())
        
        if let list = viewModel.getProductList() {
            
            for item in list {
                let view = OrderDetailProductView()
                view.setup(model: item)
                productsDataStackView.addArrangedSubview(view)
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: 100),
                    view.heightAnchor.constraint(equalToConstant: 100),
                ])
                productsHeight.constant = productsHeight.constant + 100
            }
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        updateNavigationBar(isBackButtonActive: true)
    }
    
    
    private func getCount() {
        viewModel.getShoppingCartCount(success: {
            [weak self] in
            guard let self = self else { return }
        }) {
            [weak self] (errorViewModel) in
            guard let self = self else { return }
        }
    }
    
    @objc
    func onClickCargoText(sender:UITapGestureRecognizer) {
        UIPasteboard.general.string = viewModel.getShippingTrackingCode()
    }
    
}

