//
//  CheckOutViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import MaterialComponents.MaterialButtons
import BraintreeDropIn

class CheckOutViewController: BaseViewController<CheckOutViewModel> {
    
    private struct Constants {
        static var confirmOrderButtonText: String { "confirm-order-button-text".localized }
    }
    
    @IBOutlet private weak var checkOutProgress: CheckOutProgress!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextPageButton: MDCFloatingButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var viewControllerTitle: UILabel!
    @IBOutlet private weak var confirmOrderButtonContainer: UIView!
    @IBOutlet private weak var confirmOrderButton: UIButton!
    
    var index = 0
    
    private var checkOutPageViewController: CheckOutPageViewController?
    
    init(viewModel: CheckOutViewModel){
        super.init(viewModel.getPageTitle()?.localized, viewModel: viewModel, nibName: CheckOutViewController.nibName, bundle: Bundle(for: CheckOutViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onResultEvent), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.orderInnerResponseObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadPayment), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updatePaymentMethodObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadAddress), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateAddressMethodObserve), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let checkOutPageViewController = CheckOutPageViewController(checkOutPageDelegate: self)
        addChild(checkOutPageViewController)
        checkOutPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(checkOutPageViewController.view)
        
        checkOutPageViewController.view.frame = containerView.frame
        
        self.navigationController?.navigationBar.isHidden = true
        
        checkOutPageViewController.didMove(toParent: self)
        
        self.viewControllerTitle.text = "delivery-information-page-title".localized
        
        self.checkOutPageViewController = checkOutPageViewController
    }
    
    @objc func loadPayment() {
        checkOutProgress.configureView(stage: .payment)
        setTitle(stage: .payment)
        isHidingNextButton(hide: false)
        setButton()
        self.view.layoutIfNeeded()
    }
    
    @objc func loadAddress() {
        checkOutProgress.configureView(stage: .address)
        setTitle(stage: .address)
        isHidingNextButton(hide: false)
        setButton()
        self.view.layoutIfNeeded()
    }
    
    @objc func onResultEvent() {
        let orderResponse = SRSessionManager.shared.orderResponseInnerModel
        
        if (orderResponse != nil && orderResponse?.order?.paymentType == PaymentTypeEnum.Online3DS) && (orderResponse?.payment != nil && orderResponse?.payment?._3DSecureHtml != nil) {
            let threeDSViewController = ThreeDSModalViewController(viewModel: ThreeDSModalViewModel(urlToOpen: orderResponse?.payment?._3DSecureHtml))
            threeDSViewController.delegate = self
            threeDSViewController.modalPresentationStyle = .overCurrentContext
            present(threeDSViewController, animated: true, completion: nil)
        } else if (orderResponse != nil && orderResponse?.order?.paymentType == PaymentTypeEnum.Transfer) {
            loadOrderResultSuccess(orderResponse: orderResponse ?? SROrderResponseInnerModel(),isCreditCard : false)
        } else if (orderResponse != nil && orderResponse?.order?.paymentType == PaymentTypeEnum.PayAtDoor) {
            loadOrderResultSuccess(orderResponse: orderResponse ?? SROrderResponseInnerModel(), isCreditCard: false)
        } else  if (orderResponse != nil && orderResponse?.order?.paymentType == PaymentTypeEnum.PayPal) {
            loadPaypal()
        }
    }
    
    private func loadPaypal() {
        showDropIn(clientTokenOrTokenizationKey: "sandbox_f252zhq7_hh4cpc39zq4rgjcg")
    }
    
    
    private func fetchClientToken() {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            let clientToken = String(data: data!, encoding: String.Encoding.utf8)

            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        
        let orderResponse = SRSessionManager.shared.orderResponseInnerModel
        
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCanceled == true) {
                print("CANCELED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentMethodType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
                self.loadOrderResultSuccess(orderResponse: orderResponse ?? SROrderResponseInnerModel(),isCreditCard : false)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    private func loadOrderResultSuccess(orderResponse : SROrderResponseInnerModel , isCreditCard : Bool) {
        let resultVC = SRResultViewController(viewModel: viewModel.getResultPageModel(isCreditCard : isCreditCard))
        self.prompt(resultVC, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped() {
        checkOutPageViewController?.goToNextPage()
        switch index {
        case 1:
            checkOutProgress.configureView(stage: .payment)
            setTitle(stage: .payment)
        case 2:
            checkOutProgress.configureView(stage: .info)
            setTitle(stage: .info)
            isHidingNextButton(hide: true)
            setButton()
        default:
            checkOutProgress.configureView(stage: .address)
            setTitle(stage: .address)
        }
    }
    
    @IBAction func backButtonTapped() {
        checkOutPageViewController?.goToPreviousPage()
        switch index {
        case 1:
            checkOutProgress.configureView(stage: .payment)
            setTitle(stage: .payment)
            isHidingNextButton(hide: false)
            setButton()
        case 0:
            checkOutProgress.configureView(stage: .address)
            setTitle(stage: .address)
        default:
            break
        }
        setButton()
    }
    
    
    private func setButton() {
        confirmOrderButtonContainer.isHidden = !nextPageButton.isHidden
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
            self.nextPageButton.isUserInteractionEnabled = true
            self.nextPageButton.backgroundColor = .black
        } else {
            self.nextPageButton.isUserInteractionEnabled = false
            self.nextPageButton.backgroundColor = .black.withAlphaComponent(0.35)
        }
    }
    
    func isHidingNextButton(hide: Bool?) {
        if hide == true {
            self.nextPageButton.isHidden = true
        } else {
            self.nextPageButton.isHidden = false
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
        print(currentIndex)
    }
    
}

extension CheckOutViewController: ThreeDSModalDelegate {
    func onPaymentSuccess() {
        let resultVC = SRResultViewController(viewModel: SRResultViewControllerViewModel(type: .success, orderResponse: SRSessionManager.shared.orderResponseInnerModel))
        prompt(resultVC, animated: true, completion: nil)
    }
    
    func onPaymentFailed(message: String?) {
        SRSessionManager.shared.makeOrder?.tryAgain = true
        let resultVC = SRResultViewController(viewModel: SRResultViewControllerViewModel(type: .fail, orderResponse: SRSessionManager.shared.orderResponseInnerModel,errorMessage: message))
        prompt(resultVC, animated: true, completion: nil)
    }
}
