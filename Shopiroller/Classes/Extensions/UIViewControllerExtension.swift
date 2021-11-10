//
//  UIViewControllerExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 6.10.2021.
//

import Foundation
import FittedSheets

extension UIViewController {
    
    func prompt(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.pushViewController(viewController, animated: flag)
            CATransaction.commit()
        } else {
            let navigationController = UINavigationController()
            navigationController.viewControllers = [viewController]
            navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: flag, completion: completion)
        }
    }
    
    func push(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func modal(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: flag, completion: completion)
    }
    
    func root(_ viewController: UIViewController, animated flag: Bool) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: flag, completion: {
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        })
    }
    
    func popUp(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: false, completion: completion)
        }
        
    }
    
    func disband(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            navigationController.dismiss(animated: flag, completion: completion)
        } else {
            dismiss(animated: flag, completion: completion)
        }
    }
    
    func popToRoot(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.popToRootViewController(animated: flag)
            CATransaction.commit()
        } else {
            dismiss(animated: flag, completion: completion)
        }
    }
    
    func pop(animated flag: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.popViewController(animated: flag)
            CATransaction.commit()
        } else {
            dismiss(animated: flag, completion: completion)
        }
    }
    
    func sheet(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        let options = SheetOptions(
            pullBarHeight: 0)
        let sheetController = SheetViewController(controller: viewController, sizes: [.percent(0.73)],options: options)
        sheetController.contentBackgroundColor = .white
        sheetController.pullBarBackgroundColor = .iceBlue
        sheetController.cornerRadius = 15
        sheetController.gripColor = .black
        DispatchQueue.main.async {
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(sheetController, animated: true, completion: nil)
        }
       
    }
    
    func createNavigationItem(_ image: UIImage? ,_ selector: SRAppConstants.NavigationItemSelectorType? = nil , _ isCartButton: Bool? = false ) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.tintColor = .black
        button.setImage(image)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.layer.masksToBounds = false
        button.contentEdgeInsets.right = 7
        switch selector {
        case .goToCard:
            button.addTarget(self, action: #selector(goToCard), for: .touchUpInside)
        case .searchProduct:
            button.addTarget(self, action: #selector(searchProduct), for: .touchUpInside)
        case .openOptions:
            button.addTarget(self, action: #selector(openOptions), for: .touchUpInside)
        case .goBack:
            button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        case .none:
            break
        }
        
        if isCartButton == true {
            button.createBadge(withCount: SRAppContext.shoppingCartCount)
        }
        
        return button
    }
    
    @objc func goToCard() {
        prompt(ShoppingCartViewController(viewModel: ShoppingCartViewModel())
               , animated: true, completion: nil)
    }
    
    @objc func searchProduct() {
        
    }
    
    @objc func openOptions() {
        prompt(UserAddressViewController(viewModel: UserAddressViewModel())
               , animated: true, completion: nil)
    }
    
    @objc func openMenu() {
//        prompt(OrderListViewController(viewModel: OrderListViewModel())
//               , animated: true, completion: nil)
        let vc = CheckOutViewController(viewModel: CheckOutViewModel())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func goBack() {
            pop(animated: true, completion: nil)
    }
    
    func initializeNavigationBar() {
        navigationItem.backButtonTitle = " "
        navigationController?.navigationBar.tintColor = .black
    }
    
    func updateNavigationBar(rightBarButtonItems: [UIBarButtonItem]? = nil, isBackButtonActive: Bool? = false){
        initializeNavigationBar()
        let menuButton = createNavigationItem(.menuIcon)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        
        let backButton = createNavigationItem(.backIcon , .goBack)
        
        if isBackButtonActive == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        }
        
        navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
}
