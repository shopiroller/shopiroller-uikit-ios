//
//  SRResultViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.11.2021.
//

import UIKit

class SRResultViewController: BaseViewController<SRResultViewControllerViewModel> {
    
    private struct Constants {
        static var pageTitle: String { "checkout-result-info-page-title".localized }
        static var successTitle: String { "checkout-result-info-success-title".localized }
        static var successDescription: String { "checkout-result-info-success-description" .localized }
        static var successOrderNumber: String { "checkout-result-info-success-order-number".localized }
        static var successCheckOrderButtonText: String { "checkout-result-info-success-check-order-button-text".localized }
        static var successContinueShoppingButtonText: String { "checkout-result-info-success-continue-shopping-button-text".localized }
        static var failTitle: String {  "checkout-result-info-fail-title" .localized }
        static var failDescription: String { "checkout-result-info-fail-description".localized }
        static var failMessage: String { "ccheckout-result-info-fail-message".localized }
        static var failUpdatePaymentMethodButtonText: String { "checkout-result-info-fail-update-payment-method-button-text".localized }
    }
    
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var resultTitle: UILabel!
    @IBOutlet private weak var resultDescription: UILabel!
    @IBOutlet private weak var resultDetailDescription: UILabel!
    @IBOutlet private weak var resultFirstButton: UIButton!
    @IBOutlet private weak var resultSecondButton: UIButton!
    
    init(viewModel : SRResultViewControllerViewModel) {
        super.init(Constants.pageTitle, viewModel: viewModel, nibName: SRResultViewController.nibName, bundle: Bundle(for: SRResultViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        resultTitle.textColor = .textPrimary
        resultTitle.font = .bold24
        
        resultDescription.textColor = .textPCaption
        resultDescription.font = .regular14
        
        resultFirstButton.layer.cornerRadius = 6
        resultSecondButton.layer.cornerRadius = 6
        
        resultDetailDescription.font = .semiBold14
        resultDetailDescription.textColor = .textPCaption
        
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
        resultFirstButton.titleLabel?.font = .semiBold14
        resultDetailDescription.isHidden = viewModel.isErrorMessageEmpty()
        resultDetailDescription.attributedText = viewModel.getFormattedErrorMesage()
        resultSecondButton.isHidden = true
    }
    
    private func setSuccessUI() {
        resultImageView.image = .paymentSuccess
        resultTitle.text = Constants.successTitle
        resultDescription.text = Constants.successDescription
        resultDetailDescription.isHidden = false
        resultDetailDescription.text = String(format: Constants.successOrderNumber, viewModel.getOrderNumber())
        resultFirstButton.backgroundColor = .textPrimary
        resultFirstButton.setTitle(Constants.successCheckOrderButtonText)
        resultFirstButton.setTitleColor(.white)
        resultSecondButton.backgroundColor = .buttonLight
        resultSecondButton.setTitle(Constants.successContinueShoppingButtonText)
        resultSecondButton.setTitleColor(.textPrimary)
    }
    
    @IBAction func firstButtonTapped() {
        if viewModel.getType() == .success {
            let orderDetailVC = OrderListViewController(viewModel: OrderListViewModel())
            self.prompt(orderDetailVC, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updatePaymentMethodObserve), object: nil)
        }
    }
    
    @IBAction func secondButtonTapped() {
        let mainPageVC = SRMainPageViewController(viewModel: SRMainPageViewModel())
        navigationController?.setViewControllers([mainPageVC], animated: true)
    }
    
}
