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
}

class CheckOutPageViewController: UIPageViewController {

    private var items: [UIViewController] = []
    internal let checkOutPageDelegate : CheckOutProgressPageDelegate
    
    init(checkOutPageDelegate: CheckOutProgressPageDelegate){
        self.checkOutPageDelegate = checkOutPageDelegate
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = self
        createViewControllers()
        if let firstViewController = items.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        if let scrollView = self.view.subviews.filter({$0.isKind(of: UIScrollView.self)}).first as? UIScrollView {
                     scrollView.isScrollEnabled = false
        }
    }
    
    private func createViewControllers() {
        let checkOutAdressVC = CheckOutAddressViewController(viewModel: CheckOutAddressViewModel())
        checkOutAdressVC.delegate = self
        items.append(checkOutAdressVC)
        let checkOutPaymentVC = CheckOutPaymentViewController(viewModel: CheckOutPaymentViewModel())
        items.append(checkOutPaymentVC)
        let checkOutInfoVC = CheckOutInfoViewController(viewModel: CheckOutInfoViewModel())
        items.append(checkOutInfoVC)
    }
}

extension CheckOutPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard items.count > previousIndex else {
            return nil
        }
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
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
}


extension CheckOutPageViewController : CheckOutAddressViewControllerDelegate {
    func showToastMessage() {
        checkOutPageDelegate.showSuccessfullToastMessage()
    }
    
    
}
