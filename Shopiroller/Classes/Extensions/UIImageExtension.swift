//
//  UIImageExtension.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

extension UIImage {
    
    // MARK: System Images
    static let searchIcon: UIImage = UIImage(systemName: "magnifyingglass")!
    
    static let generalCartIcon: UIImage = UIImage(systemName: "cart.fill")!
    
    static let backIcon: UIImage = UIImage(systemName: "chevron.left")!
    
    // MARK: Project Images
    
    static let billingAddress: UIImage = UIImage(named: "billingAddress", in: .shopiroller, with: nil)!
    
    static let cargoShippingImage: UIImage = UIImage(named: "cargoShippingImage", in: .shopiroller, with: nil)!
    
    static let clearCart: UIImage = UIImage(named: "clearCart", in: .shopiroller, with: nil)!
    
    static let deliveryAddress: UIImage = UIImage(named: "deliveryAddress", in: .shopiroller, with: nil)!
    
    static let deliveryTerms: UIImage = UIImage(named: "deliveryTerms", in: .shopiroller, with: nil)!
    
    static let emptyProduct: UIImage = UIImage(named: "emptyProductImage", in: .shopiroller, with: nil)!
    
    static let emptyBillingAddresses: UIImage = UIImage(named: "emptyBillingAddresses", in: .shopiroller, with: nil)!
    
    static let emptyShippingAddresses: UIImage = UIImage(named: "emptyShippingAddresses", in: .shopiroller, with: nil)!
    
    static let emptyShoppingCart: UIImage = UIImage(named: "emptyShoppingCart", in: .shopiroller, with: nil)!
    
    static let filterIcon: UIImage = UIImage(named: "filterIcon", in: .shopiroller, with: nil)!
    
    static let menuIcon: UIImage = UIImage(named: "menuIcon", in: .shopiroller, with: nil)!
    
    static let moreIcon: UIImage = UIImage(named: "moreIcon", in: .shopiroller, with: nil)!
    
    static let outOfStock: UIImage = UIImage(named: "outOfStock", in: .shopiroller, with: nil)!
    
    static let paymentFailed: UIImage = UIImage(named: "paymentFailed", in: .shopiroller, with: nil)!
    
    static let rightArrow: UIImage = UIImage(named: "rightArrow", in: .shopiroller, with: nil)!
    
    static let shareIcon: UIImage = UIImage(named: "shareIcon", in: .shopiroller, with: nil)!
    
    static let sortIcon: UIImage = UIImage(named: "sortIcon", in: .shopiroller, with: nil)!
    
    static let validateCart: UIImage = UIImage(named: "updateCart", in: .shopiroller, with: nil)!
    
    // MARK: Order Statusses
    static let orderApproved: UIImage = UIImage(named: "orderApproved", in: .shopiroller, with: nil)!
    
    static let orderCancelled: UIImage = UIImage(named: "orderCancelled", in: .shopiroller, with: nil)!
    
    static let orderDelivered: UIImage = UIImage(named: "orderDelivered", in: .shopiroller, with: nil)!
    
    static let orderPaymentFailed: UIImage = UIImage(named: "orderPaymentFailed", in: .shopiroller, with: nil)!
    
    static let orderPreparing: UIImage = UIImage(named: "orderPreparing", in: .shopiroller, with: nil)!
    
    static let orderRefunded: UIImage = UIImage(named: "orderRefunded", in: .shopiroller, with: nil)!
    
    static let orderRequestCancelled: UIImage = UIImage(named: "orderRequestCancelled", in: .shopiroller, with: nil)!
    
    static let orderShipped: UIImage = UIImage(named: "orderShipped", in: .shopiroller, with: nil)!
    
    static let orderWaitingApproval: UIImage = UIImage(named: "orderWaitingApproval", in: .shopiroller, with: nil)!
    
    static let orderWaitingPayment: UIImage = UIImage(named: "orderWaitingPayment", in: .shopiroller, with: nil)!
    
    static let orderWaitingShipment: UIImage = UIImage(named: "orderWaitingShipment", in: .shopiroller, with: nil)!
    
    static let orderWaitingSupplying: UIImage = UIImage(named: "orderWaitingSupplying", in: .shopiroller, with: nil)!
    
    static let radioOn : UIImage = UIImage(named: "radioOn", in: .shopiroller, with: nil)!
    
    static let radioOff : UIImage = UIImage(named: "radioOff", in: .shopiroller, with: nil)!
    
    static let emptyPaymentMethod: UIImage = UIImage(named: "emptyPaymentMethod", in: .shopiroller, with: nil)!
    
    static let creditCartIcon : UIImage = UIImage(named: "creditCartIcon", in: .shopiroller, with: nil)!
    
    static let bankIcon : UIImage = UIImage(named: "bankIcon", in: .shopiroller, with: nil)!
    
    static let paypalIcon : UIImage = UIImage(named: "paypalIcon", in: .shopiroller, with: nil)!
    
    static let payAtTheDoorIcon : UIImage = UIImage(named: "payAtTheDoorIcon", in: .shopiroller, with: nil)!
    
    static let masterCardIcon : UIImage = UIImage(named: "visaCard", in: .shopiroller, with: nil)!
    
    static let visaIcon : UIImage = UIImage(named: "masterCard", in: .shopiroller, with: nil)!
    
    static let copyIcon : UIImage = UIImage(systemName: "doc.on.doc.fill")!
    
    static let cartIcon : UIImage = UIImage(named: "cartIcon", in: .shopiroller, with: nil)!
    
    static let paymentIcon : UIImage = UIImage(named: "paymentIcon", in: .shopiroller, with: nil)!
    
    static let billingAddressIcon : UIImage = UIImage(named: "billingAddressIcon", in: .shopiroller, with: nil)!
    
    static let deliveryAddressIcon : UIImage = UIImage(named: "deliveryAddressIcon", in: .shopiroller, with: nil)!
    
    static let paymentSuccess : UIImage = UIImage(named: "paymentSuccess",in: .shopiroller , with: nil)!
    
    static let noProductsIcon : UIImage = UIImage(named: "noProductsIcon",in: .shopiroller , with: nil)!
    
    static let checkBoxChecked : UIImage = UIImage(named: "checkBoxChecked",in: .shopiroller , with: nil)!
    
    static let checkBoxUnchecked : UIImage = UIImage(named: "checkBoxUnchecked",in: .shopiroller , with: nil)!
    
    static let dropdownIcon : UIImage = UIImage(systemName: "chevron.down.square")!
    
}

extension UIImageView {
    
    func setImages(url:String) {
        let activityIndicator = UIActivityIndicatorView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            activityIndicator.frame = CGRect(x: (self.frame.width / 2) - 30, y: (self.frame.height / 2) - 30, width: 60, height: 60)
            activityIndicator.style = .medium
            activityIndicator.color = .textPrimary
            self.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            self.kf.setImage(with: URL(string: "\(url)?width=\(self.frame.width)"), placeholder: UIImage(named: "emptyProductImage", in: .shopiroller, with: nil)!, options: nil, progressBlock: nil) { (img) in
                activityIndicator.stopAnimating()
            }
        }
    }
}
