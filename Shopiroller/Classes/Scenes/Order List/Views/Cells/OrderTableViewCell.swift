//
//  OrderCellTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit


class OrderTableViewCell: UITableViewCell {
    
    private struct Constants {
    
        static var successTransaction: String { return "success-transaction".localized }
        
        static var pendiginTransaction: String { return "pending-transaction".localized }
        
        static var orderNo: String { return "order-no".localized }
        
    }
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var orderNo: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusView.layer.cornerRadius = 15
        
        orderNo.font = .semiBold14
        orderNo.textColor = .textPrimary
        
        date.font = .regular12
        date.textColor = .textPCaption
        
        price.font = .semiBold14
        price.textColor = .textPrimary
        
        status.font = .regular12
        status.textColor = .textPrimary
        
        containerView.layer.cornerRadius = 6
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.textSecondary10.cgColor
    }
    
    func setup(model: OrderDetailModel) {
        orderNo.text = Constants.orderNo + (model.orderCode ?? "")
        date.text = ECommerceUtil.convertServerDate(date: model.createdDate, toFormat: ECommerceUtil.ddMMMMyyy)
        time.text = ECommerceUtil.convertServerDate(date: model.createdDate, toFormat: ECommerceUtil.EEEEhhmm)
        price.text = ECommerceUtil.getFormattedPrice(price: model.totalPrice, currency: model.currency)
        status.text = model.currentStatus?.text
        statusView.backgroundColor = model.currentStatus?.backgroundColor
    }
    
}
