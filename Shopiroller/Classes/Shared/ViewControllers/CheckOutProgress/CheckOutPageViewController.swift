//
//  CheckOutPageViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import UIKit

protocol CheckOutProgressPageDelegate {
    func currentPageIndex(currentIndex: Int)
    func showSuccessfullToastMessage()
    func hideConfirmOrderButton()
    func popLastViewController()
    func isHidingNextButton(hide: Bool?)
    func isEnabledNextButton(enabled: Bool?)
}

class CheckOutPageViewController: UIPageViewController {

    private var items: [UIViewController] = []
    internal let checkOutPageDelegate : CheckOutProgressPageDelegate
    var checkOutPaymentVC: CheckOutPaymentViewController?
    var checkOutInfoVC: CheckOutInfoViewController?
    
    init(checkOutPageDelegate: CheckOutProgressPageDelegate){
        self.checkOutPageDelegate = checkOutPageDelegate
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let firstViewController = self.items.first {
                self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            }
        }
        
        dataSource = self
        
        self.createViewControllers()
                
        if let scrollView = self.view.subviews.filter({$0.isKind(of: UIScrollView.self)}).first as? UIScrollView {
            scrollView.isScrollEnabled = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadPayment), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updatePaymentMethodObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadAddress), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateAddressMethodObserve), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadInfo), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateCheckOutInfoPage), object: nil)
        
    }
    
    @objc func loadPayment() {
        setViewControllers([checkOutPaymentVC!],
                           direction: .reverse, animated: true, completion: nil)
        
    }
    
    @objc func loadAddress() {
        setViewControllers([items[0]],
                           direction: .reverse, animated: true, completion: nil)
    }
    
    @objc func loadInfo() {
        setViewControllers([checkOutInfoVC!],
                           direction: .reverse, animated: true, completion: nil)
    }
    
        
    private func createViewControllers() {
        let checkOutAdressVC = CheckOutAddressViewController(viewModel: CheckOutAddressViewModel())
        checkOutAdressVC.delegate = checkOutPageDelegate
        items.append(checkOutAdressVC)
        checkOutPaymentVC = CheckOutPaymentViewController(viewModel: CheckOutPaymentViewModel())
        checkOutPaymentVC!.delegate = checkOutPageDelegate
        items.append(checkOutPaymentVC!)
        checkOutInfoVC = CheckOutInfoViewController(viewModel: CheckOutInfoViewModel())
        checkOutInfoVC!.delegate = checkOutPageDelegate
        items.append(checkOutInfoVC!)
    }
}

extension CheckOutPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            checkOutPageDelegate.popLastViewController()
            return nil
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        checkOutPageDelegate.currentPageIndex(currentIndex: previousIndex)
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return nil
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        checkOutPageDelegate.currentPageIndex(currentIndex: nextIndex)
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
}
