//
//  SRResultViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.11.2021.
//

import UIKit

class SRResultViewController: BaseViewController<SRResultViewControllerViewModel> {
    
    private struct Constants {
        static var pageTitle: String { "checkout-order-info-success-title".localized }
        static var successTitle: String { "checkout-order-info-success-title".localized }
        static var successDescription: String { "checkout-order-info-success-description" .localized }
        static var successOrderNumber: String { "checkout-order-info-success-order-number".localized }
        static var successCheckOrderButtonText: String { "checkout-order-info-success-check-order-button-text".localized }
        static var successContinueShoppingButtonText: String { "checkout-order-info-success-continue-shopping-button-text".localized }
        static var failTitle: String {  "checkout-order-info-fail-title" .localized }
        static var failDescription: String { "checkout-order-info-fail-description".localized }
        static var failMessage: String { "ccheckout-order-info-fail-message".localized }
        static var failUpdatePaymentMethodButtonText: String { "checkout-order-info-fail-update-payment-method-button-text".localized }
    }
    
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var resultTitle: UILabel!
    @IBOutlet private weak var resultDescription: UILabel!
    @IBOutlet private weak var resultOrderNumber: UILabel!
    @IBOutlet private weak var resultFirstButton: UIButton!
    @IBOutlet private weak var resultSecondButton: UIButton!
    
    init(viewModel : SRResultViewControllerViewModel) {
        super.init("Order Info", viewModel: viewModel, nibName: SRResultViewController.nibName, bundle: Bundle(for: SRResultViewController.self))
    }
    
    override func setup() {
        super.setup()
        updateNavigationBar(rightBarButtonItems: nil, isBackButtonActive: true)
        setUpLayout()
        
    }
    
    private func setUpLayout() {
        switch viewModel.getType() {
        case .fail:
            setFailUI()
        case .success:
            setSuccessUI()
        case .none:
            break
        }
    }
    
    private func setFailUI() {
        resultImageView.image = .paymentFailed
        resultTitle.text = Constants.failTitle
        resultDescription.text = Constants.failDescription
        resultFirstButton.backgroundColor = .textPrimary
        resultFirstButton.setTitle(Constants.failUpdatePaymentMethodButtonText)
        resultFirstButton.setTitleColor(.white)
        resultOrderNumber.isHidden = true
        resultSecondButton.isHidden = true
    }
    
    private func setSuccessUI() {
        resultImageView.image = .paymentSuccess
        resultTitle.text = Constants.successTitle
        resultDescription.text = Constants.successDescription
        resultOrderNumber.text = Constants.successOrderNumber
        resultFirstButton.backgroundColor = .textPrimary
        resultFirstButton.setTitle(Constants.successCheckOrderButtonText)
        resultFirstButton.setTitleColor(.white)
        resultSecondButton.backgroundColor = .buttonLight
        resultSecondButton.setTitle(Constants.successContinueShoppingButtonText)
        resultSecondButton.setTitleColor(.textPrimary)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
