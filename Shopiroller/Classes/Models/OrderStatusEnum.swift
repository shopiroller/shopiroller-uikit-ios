//
//  OrderStatusEnum.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 20.10.2021.
//

import Foundation

enum OrderStatusEnum: String, Codable {
    
    case WaitingPayment
    case WaitingApproval
    case Approved
    case WaitingForSupplying
    case Preparing
    case Shipped
    case Delivered
    case CancelRequested
    case Canceled
    case Refunded
    case PaymentFailed
    
    var text : String {
        switch self {
        case .WaitingPayment:
            return "e_commerce_order_status_waiting_payment".localized
        case .WaitingApproval:
            return "e_commerce_order_status_waiting_approval".localized
        case .Approved:
            return "e_commerce_order_status_approved".localized
        case .WaitingForSupplying:
            return "e_commerce_order_status_waiting_supplying".localized
        case .Preparing:
            return "e_commerce_order_status_preparing".localized
        case .Shipped:
            return "e_commerce_order_status_shipped".localized
        case .Delivered:
            return "e_commerce_order_status_delivered".localized
        case .CancelRequested:
            return "e_commerce_order_status_cancel_requested".localized
        case .Canceled:
            return "e_commerce_order_status_canceled".localized
        case .Refunded:
            return "e_commerce_order_status_refunded".localized
        case .PaymentFailed:
            return "e_commerce_order_status_payment_failed".localized
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .WaitingPayment:
            return .mainSecondary
        case .WaitingApproval:
            return .mainSecondary
        case .Approved:
            return .badgeSuccess
        case .WaitingForSupplying:
            return .mainSecondary
        case .Preparing:
            return .mainSecondary
        case .Shipped:
            return .mainSecondary
        case .Delivered:
            return .badgeSuccess
        case .CancelRequested:
            return .dangerBadge
        case .Canceled:
            return .dangerBadge
        case .Refunded:
            return .dangerBadge
        case .PaymentFailed:
            return .dangerBadge
        }
    }
    
    var image: UIImage {
        switch self {
        case .WaitingPayment:
            return .orderWaitingPayment
        case .WaitingApproval:
            return .orderWaitingApproval
        case .Approved:
            return .orderApproved
        case .WaitingForSupplying:
            return .orderWaitingSupplying
        case .Preparing:
            return .orderPreparing
        case .Shipped:
            return .orderShipped
        case .Delivered:
            return .orderDelivered
        case .CancelRequested:
            return .orderRequestCancelled
        case .Canceled:
            return .orderCancelled
        case .Refunded:
            return .orderRefunded
        case .PaymentFailed:
            return .orderPaymentFailed
        }
    }
}
