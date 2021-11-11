//
//  CheckOutViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit
import MaterialComponents.MaterialButtons

class CheckOutViewController: BaseViewController<CheckOutViewModel> {
    @IBOutlet private weak var checkOutProgress: CheckOutProgress!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextPageButton: MDCFloatingButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var viewControllerTitle: UILabel!
    
    var index = 0
    
    private var checkOutPageViewController: CheckOutPageViewController?
    
    init(viewModel: CheckOutViewModel){
        super.init(viewModel.getPageTitle()?.localized, viewModel: viewModel, nibName: CheckOutViewController.nibName, bundle: Bundle(for: CheckOutViewController.self))
    }
 
    override func setup() {
        super.setup()
        
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
    
    @IBAction func nextButtonTapped() {
        checkOutPageViewController?.goToNextPage()
        switch index {
        case 1:
            checkOutProgress.configureView(stage: .payment)
            setTitle(stage: .payment)
        case 2:
            checkOutProgress.configureView(stage: .info)
            setTitle(stage: .info)
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
        case 0:
            checkOutProgress.configureView(stage: .address)
            setTitle(stage: .address)
        default:
            break
        }
        
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