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
    
    func createNavigationItem(_ image: UIImage? ,_ selector: SRAppConstants.NavigationItemSelectorType? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        button.tintColor = ShopirollerApp.shared.theme.navigationIconsTintColor
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
        return button
    }
    
    @objc func goToCard() {
        if ShopirollerApp.shared.isUserLoggedIn() {
            prompt(ShoppingCartViewController(viewModel: ShoppingCartViewModel())
               , animated: true, completion: nil)
        } else {
            ShopirollerApp.shared.delegate?.userLoginNeeded()
        }
    }
    
    @objc func searchProduct() {
        let searchVC = SearchViewController(viewModel: SearchViewModel())
        self.prompt(searchVC, animated: true, completion: nil)
    }
    
    @objc func openOptions() {
        let actionSheetController = UIAlertController(title: "Select", message: "Select An Action", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)

        let chooseOrderAction = UIAlertAction(title: "Siparislerim", style: .default) { action -> Void in
            let orderListVC = OrderListViewController(viewModel: OrderListViewModel())
            self.prompt(orderListVC, animated: true, completion: nil)
        }
        actionSheetController.addAction(chooseOrderAction)
        
        let chooseAddressAction = UIAlertAction(title: "Adreslerim", style: .default) { action -> Void in
            let addressListVC = UserAddressViewController(viewModel: UserAddressViewModel())
            self.prompt(addressListVC, animated: true, completion: nil)
        }
        actionSheetController.addAction(chooseAddressAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @objc func goBack() {
        pop(animated: true, completion: nil)
    }
    
    func initializeNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backgroundColor = ShopirollerApp.shared.theme.navigationBarTintColor
//        navigationController?.navigationBar.barTintColor = ShopirollerApp.shared.theme.navigationBarTintColor
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: ShopirollerApp.shared.theme.navigationTitleTintColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
    }
    
    func updateNavigationBar(rightBarButtonItems: [UIBarButtonItem]? = nil, isBackButtonActive: Bool? = false){
        initializeNavigationBar()
        
        let backButton = createNavigationItem(.backIcon , .goBack)
        
        if isBackButtonActive == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    func showAlert(title: String?,
                   message: String?,
                   isMessageHtml : Bool? = false,
                   htmlMessage : NSAttributedString? = nil,
                   url: String? = nil,
                   icon: UIImage? = nil,
                   isTopViewHidden: Bool? = false,
                   confirmButtonTitle: String? = nil,
                   confirmed: (() -> Void)? = nil,
                   canceled: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let noInternetConnectionAction = UIAlertAction(title: "no-internet-connection-button-text".localized, style: .default) { action -> Void in
            self.pop(animated: true, completion: nil)
        }
        alert.addAction(noInternetConnectionAction)
        
        popUp(alert)
    }
    
    func showAlertError(viewModel: ErrorViewModel?) {
        if viewModel?.error == .network {
            self.view.makeToast("no-internet-connection-description".localized)
        } else {
            self.view.makeToast("general-error-description".localized)
        }
    }
    
    func showNoConnectionAlert() {
        showAlert(title: "no-internet-connection-title".localized, message: "no-internet-connection-description".localized)
    }

    
}
