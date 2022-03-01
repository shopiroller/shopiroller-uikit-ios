//
//  CheckOutViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import MaterialComponents.MaterialButtons
import Stripe

class CheckOutViewController: BaseViewController<CheckOutViewModel> {
    
    private struct Constants {
        static var confirmOrderButtonText: String { "confirm-order-button-text".localized }
        static var checkoutAdressNextStepText: String { "checkout-address-next-step-title".localized }
        static var checkoutPaymentNextStepText: String { "checkout-payment-next-step-title".localized }
    }
    
    @IBOutlet private weak var checkOutProgress: CheckOutProgress!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextPageButton: MDCFloatingButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var viewControllerTitle: UILabel!
    @IBOutlet private weak var confirmOrderButtonContainer: UIView!
    @IBOutlet private weak var confirmOrderButton: UIButton!
    @IBOutlet private weak var bottomSafeAreaLayout: UIView!
    @IBOutlet private weak var nextPageContainer: UIView!
    @IBOutlet private weak var nextPageTitleLabel: UILabel!
    
    
    var index = 0
    
    private var checkOutPageViewController: CheckOutPageViewController?
    private var paymentSheet: PaymentSheet?
    private var customerConfig = PaymentSheet.Configuration()
    private var paymentIntentClientSecret: String?
    private var paymentIntentPaymentId: String?

    init(viewModel: CheckOutViewModel){
        super.init(viewModel.getPageTitle()?.localized, viewModel: viewModel, nibName: CheckOutViewController.nibName, bundle: Bundle(for: CheckOutViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onResultEvent), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadPayment), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updatePaymentMethodObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadAddress), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateAddressMethodObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadInfo), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateCheckOutInfoPage), object: nil)
        
        viewControllerTitle.font = viewControllerTitle.font.withSize(17)
        viewControllerTitle.textColor = .black
        viewControllerTitle.text = "delivery-information-page-title".localized
        
        nextPageTitleLabel.font = .regular12    
        nextPageTitleLabel.text = Constants.checkoutAdressNextStepText

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let checkOutPageViewController = CheckOutPageViewController(checkOutPageDelegate: self)
            self.addChild(checkOutPageViewController)
            checkOutPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.containerView.addSubview(checkOutPageViewController.view)
            
            checkOutPageViewController.view.frame = self.containerView.frame
            
            self.navigationController?.navigationBar.isHidden = true
            
            checkOutPageViewController.didMove(toParent: self)
            
            self.checkOutPageViewController = checkOutPageViewController
        }
        
    }
    
    
    @objc func loadPayment() {
        checkOutProgress.configureView(stage: .payment)
        setTitle(stage: .payment)
        isEnabledNextButton(enabled: true)
        isHidingNextButton(hide: false)
        nextPageTitleLabel.text = Constants.checkoutPaymentNextStepText
        setButton()
        self.view.layoutIfNeeded()
    }
    
    @objc func loadAddress() {
        checkOutProgress.configureView(stage: .address)
        setTitle(stage: .address)
        isHidingNextButton(hide: false)
        nextPageTitleLabel.text = Constants.checkoutAdressNextStepText
        setButton()
        self.view.layoutIfNeeded()
    }
    
    @objc func loadInfo() {
        checkOutProgress.configureView(stage: .info)
        setTitle(stage: .info)
        isHidingNextButton(hide: true)
        setButton()
        self.view.layoutIfNeeded()
    }
    
    @objc func onResultEvent() {
        if let orderResponse = SRSessionManager.shared.orderResponseInnerModel {
            if (orderResponse.order?.paymentType == PaymentTypeEnum.Online3DS) && (orderResponse.payment != nil && orderResponse.payment?._3DSecureHtml != nil) {
                let threeDSViewController = ThreeDSModalViewController(viewModel: ThreeDSModalViewModel(urlToOpen: orderResponse.payment?._3DSecureHtml))
                threeDSViewController.delegate = self
                threeDSViewController.modalPresentationStyle = .overCurrentContext
                present(threeDSViewController, animated: true, completion: nil)
            } else if (orderResponse.order?.paymentType == PaymentTypeEnum.Transfer) {
                loadOrderResultPage(isSuccess: true)
            } else if (orderResponse.order?.paymentType == PaymentTypeEnum.PayAtDoor) {
                loadOrderResultPage(isSuccess: true)
            } else if (orderResponse.order?.paymentType == PaymentTypeEnum.Stripe) {
                self.paymentIntentClientSecret = orderResponse.payment?.token ?? ""
                self.paymentIntentPaymentId = paymentIntentClientSecret?.substring(toIndex: 27)
                StripeAPI.defaultPublishableKey = orderResponse.payment?.publishableKey
                viewModel.stripeOrderStatusModel = SRStripeOrderStatusModel(paymentId: paymentIntentPaymentId, orderId: orderResponse.order?.id)
                loadPaymentSheet()
            }
        } else {
            loadOrderResultPage(isSuccess: false)
        }
     
    }
    
    private func loadPaymentSheet() {
        guard let paymentIntentClientSecret = self.paymentIntentClientSecret else {
                    return
                }
        customerConfig.allowsDelayedPaymentMethods = true
        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret , configuration: customerConfig)
        handlePaymentResult()
    }
    
    private func handlePaymentResult() {
        if presentedViewController != nil {
            presentedViewController?.dismiss(animated: false, completion: {
                self.presentStripe()
            })
        } else {
            self.presentStripe()
        }
    }
    
    private func presentStripe() {
        paymentSheet?.present(from: self) { paymentResult in
            switch paymentResult {
            case .completed:
                self.setSuccessRequest()
                self.loadOrderResultPage(isSuccess: true)
            case .canceled:
                NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateCheckOutInfoPage), object: nil)
            case .failed(_):
                self.setFailRequest()
                self.loadOrderResultPage(isSuccess: false)
            }
        }
    }
    
    private func setSuccessRequest() {
        viewModel.setStripeSuccessRequest(success: {
            SRSessionManager.shared.makeOrder?.tryAgain = false
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
            self.loadOrderResultPage(isSuccess: false)
            SRSessionManager.shared.makeOrder?.tryAgain = true
        }
    }
    
    private func setFailRequest() {
        viewModel.setStripeFailRequest(success: {
            SRSessionManager.shared.makeOrder?.tryAgain = true
        })
        { [weak self] (errorViewModel) in
            guard let self = self else { return }
            self.showAlertError(viewModel: errorViewModel)
            self.loadOrderResultPage(isSuccess: false)
            SRSessionManager.shared.makeOrder?.tryAgain = true
        }
    }
    
    private func loadOrderResultPage(isSuccess : Bool) {
        let resultVC = SRResultViewController(viewModel: viewModel.getResultPageModel(isSuccess: isSuccess))
        self.prompt(resultVC, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped() {
        checkOutPageViewController?.goToNextPage()
        switch index {
        case 1:
            checkOutProgress.configureView(stage: .payment)
            setTitle(stage: .payment)
            isHidingNextButton(hide: false)
            nextPageTitleLabel.text = Constants.checkoutPaymentNextStepText
            setButton()
        case 2:
            checkOutProgress.configureView(stage: .info)
            setTitle(stage: .info)
            isHidingNextButton(hide: true)
            setButton()
            self.view.layoutIfNeeded()
        default:
            loadAddress()
        }
    }
    
    @IBAction func backButtonTapped() {
        checkOutPageViewController?.goToPreviousPage()
        switch index {
        case 1:
            checkOutProgress.configureView(stage: .payment)
            setTitle(stage: .payment)
            isHidingNextButton(hide: false)
            nextPageTitleLabel.text = Constants.checkoutPaymentNextStepText
            setButton()
        case 0:
            checkOutProgress.configureView(stage: .address)
            isHidingNextButton(hide: false)
            nextPageTitleLabel.text = Constants.checkoutAdressNextStepText
            setTitle(stage: .address)
        default:
            break
        }
        setButton()
    }
    
    
    private func setButton() {
        bottomSafeAreaLayout.isHidden = !nextPageContainer.isHidden
        confirmOrderButtonContainer.isHidden = !nextPageContainer.isHidden
        confirmOrderButtonContainer.backgroundColor = .textPrimary
        confirmOrderButton.setTitle(Constants.confirmOrderButtonText)
        confirmOrderButton.setTitleColor(.white)
    }
    
    private func setTitle(stage : ProgressStageEnum) {
        switch stage {
        case .address:
            self.viewControllerTitle.text = "delivery-information-page-title".localized
        case .payment:
            self.viewControllerTitle.text = "payment-information-page-title".localized
        case .info:
            self.viewControllerTitle.text =
            "info-information-page-title".localized
        }
    }
    
    @IBAction func confirmButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.userConfirmOrderObserve), object: nil)
    }
}

extension CheckOutViewController : CheckOutProgressPageDelegate {
    
    func isEnabledNextButton(enabled: Bool?) {
        if enabled == true {
            nextPageTitleLabel.textColor = .textPrimary.withAlphaComponent(0.7)
            self.nextPageButton.isUserInteractionEnabled = true
            self.nextPageButton.backgroundColor = .black
        } else {
            self.nextPageButton.isUserInteractionEnabled = false
            self.nextPageButton.backgroundColor = .black.withAlphaComponent(0.35)
            nextPageTitleLabel.textColor = .textPrimary.withAlphaComponent(0.35)
        }
    }
    
    func isHidingNextButton(hide: Bool?) {
        if hide == true {
            self.nextPageContainer.isHidden = true
        } else {
            self.nextPageContainer.isHidden = false
        }
    }
    
    
    func popLastViewController() {
        self.pop(animated: true, completion: nil)
    }
    
    func showSuccessfullToastMessage() {
        self.view.makeToast(String(format: "address-bottom-view-address-saved-text".localized),position: ToastPosition.bottom)
    }
    
    func currentPageIndex(currentIndex: Int) {
        self.index = currentIndex
    }
    
}

extension CheckOutViewController: ThreeDSModalDelegate {
    func onPaymentSuccess() {
        self.loadOrderResultPage(isSuccess: true)
    }
    
    func onPaymentFailed(message: String?) {
        DispatchQueue.main.async {
            self.viewModel.errorMessage = message
        }
        SRSessionManager.shared.makeOrder?.tryAgain = true
        self.loadOrderResultPage(isSuccess: false)
    }
}
