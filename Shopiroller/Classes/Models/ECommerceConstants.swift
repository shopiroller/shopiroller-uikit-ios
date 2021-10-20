//
//  ECommerceConstants.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 20.10.2021.
//

import Foundation

enum OrderStatusEnum: String, Codable {
    
    case WaitingPayment = "WaitingPayment"
    case WaitingApproval = "WaitingApproval"
    case Approved = "Approved"
    case WaitingForSupplying = "WaitingForSupplying"
    case Preparing = "Preparing"
    case Shipped = "Shipped"
    case Delivered = "Delivered"
    case CancelRequested = "CancelRequested"
    case Canceled = "Canceled"
    case Refunded = "Refunded"
    case PaymentFailed = "PaymentFailed"
    
    var text : String {
        switch self {
        case .WaitingPayment:
            return "WaitingPayment".localized
        case .WaitingApproval:
            return "WaitingApproval".localized
        case .Approved:
            return "Approved".localized
        case .WaitingForSupplying:
            return "WaitingForSupplying".localized
        case .Preparing:
            return "Preparing".localized
        case .Shipped:
            return "Shipped".localized
        case .Delivered:
            return "Delivered".localized
        case .CancelRequested:
            return "CancelRequested".localized
        case .Canceled:
            return "Canceled".localized
        case .Refunded:
            return "Refunded".localized
        case .PaymentFailed:
            return "PaymentFailed".localized
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
    
    
}
