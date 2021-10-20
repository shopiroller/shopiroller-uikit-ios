//
//  OrderCellTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

private struct Constants {
    
    static var successTransaction: String { return "success-transaction".localized}
    
    static var pendiginTransaction: String { return "pending-transaction".localized}
    
    static var orderNo: String { return "order-no".localized}
}
class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // corner radius
        statusView.layer.cornerRadius = 30
        
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.textSecondary10.cgColor
        
    }
    
    func setup(model: SROrderModel) {
      //  orderNo.text = Constants.orderNo + model.orderCode
        //date.text = model.createdDate
        //price.text = model.totalPrice + model.currency
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
