//
//  AddressListViewControlelr.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import Foundation

protocol AddressListPageDelegate: AnyObject {
    func pageViewController(currentIndex: Int)
}

class AddressListPageViewController: UIPageViewController {
    
    private var items: [UIViewController] = []
    private weak var addressDelegate: AddressListPageDelegate?
    
    init(addressDelegate: AddressListPageDelegate?) {
        self.addressDelegate = addressDelegate
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func populateItems() {
        let shippingVC = SRAddressListViewController(viewModel: SRAddressListViewModel(state: .shipping))
        shippingVC.view.tag = 0
        items.append(shippingVC)
        let billingVC = SRAddressListViewController(viewModel: SRAddressListViewModel(state: .billing))
        billingVC.view.tag = 1
        items.append(billingVC)
    }
    
}

extension AddressListPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if(previousViewControllers[0].view.tag == 0) {
                addressDelegate?.pageViewController(currentIndex: 1)
            }else{
                addressDelegate?.pageViewController(currentIndex: 0)
            }
        }
    }
}

extension AddressListPageViewController: UIPageViewControllerDataSource {
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
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                  return 0
              }
        
        return firstViewControllerIndex
    }
}
