//
//  OrderCellTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit


class OrderTableViewCell: UITableViewCell {
    private struct Constants {
        
        static var successTransaction: String { return "success-transaction".localized}
        
        static var pendiginTransaction: String { return "pending-transaction".localized}
        
        static var orderNo: String { return "order-no".localized}
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusView.layer.cornerRadius = 15
        
        containerView.layer.cornerRadius = 6
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.textSecondary10.cgColor
    }
    
    func setup(model: SROrderModel) {
        orderNo.text = Constants.orderNo + (model.orderCode ?? "")
        date.text = ECommerceUtil.convertServerDate(date: model.createdDate, toFormat: ECommerceUtil.ddMMMMyyy)
        time.text = ECommerceUtil.convertServerDate(date: model.createdDate, toFormat: ECommerceUtil.EEEEhhmm)
        price.text = ECommerceUtil.getFormattedPrice(price: model.totalPrice, currency: model.currency)
        status.text = model.currentStatus?.text
        statusView.backgroundColor = model.currentStatus?.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
