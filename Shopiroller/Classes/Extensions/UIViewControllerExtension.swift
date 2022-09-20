//
//  UIViewControllerExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 6.10.2021.
//

import Foundation
import FittedSheets
import UIKit

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
        navigationController.modalPresentationStyle = .overCurrentContext
        present(navigationController, animated: flag, completion: completion)
    }
    
    func post(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .fullScreen
        reConfigureNavigationBarAppearance(navigationController: navigationController)
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
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(sheetController, animated: true, completion: nil)
        
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
            prompt(SRShoppingCartViewController(viewModel: SRShoppingCartViewModel())
               , animated: true, completion: nil)
        } else {
            ShopirollerApp.shared.delegate?.userLoginNeeded(navigationController: self.navigationController)
        }
    }
    
    @objc func searchProduct() {
        let searchVC = SRSearchViewController(viewModel: SRSearchViewModel())
        self.prompt(searchVC, animated: true, completion: nil)
    }
    
    @objc func openOptions() {
        let actionSheetController = UIAlertController(title: "Select", message: "Select An Action", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)

        let chooseOrderAction = UIAlertAction(title: "Siparislerim", style: .default) { action -> Void in
            let orderListVC = SROrderListViewController(viewModel: SROrderListViewModel())
            self.prompt(orderListVC, animated: true, completion: nil)
        }
        actionSheetController.addAction(chooseOrderAction)
        
        let chooseAddressAction = UIAlertAction(title: "Adreslerim", style: .default) { action -> Void in
            let addressListVC = SRUserAddressViewController(viewModel: SRUserAddressViewModel())
            self.prompt(addressListVC, animated: true, completion: nil)
        }
        actionSheetController.addAction(chooseAddressAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @objc func goBack() {
        if let navigationController = navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func initializeNavigationBar(_ isHidingBackButton: Bool? = true) {
        navigationItem.hidesBackButton = isHidingBackButton ?? true
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backgroundColor = ShopirollerApp.shared.theme.navigationBarTintColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: ShopirollerApp.shared.theme.navigationTitleTintColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]

    }
    
    func updateNavigationBar(rightBarButtonItems: [UIBarButtonItem]? = nil, isBackButtonActive: Bool? = false) {
        initializeNavigationBar(isBackButtonActive)
        
        let backButton = createNavigationItem(.backIcon , .goBack)
        
        navigationItem.hidesBackButton = isBackButtonActive ?? false
        
        if isBackButtonActive == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    private func reConfigureNavigationBarAppearance(navigationController: UINavigationController?) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navBarAppearance.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
            navBarAppearance.backgroundColor = ShopirollerApp.shared.theme.navigationBarTintColor
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
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
        let noInternetConnectionAction = UIAlertAction(title: "e_commerce_general_ok_button_text".localized, style: .default) { action -> Void in
            self.pop(animated: true, completion: nil)
        }
        alert.addAction(noInternetConnectionAction)
        
        popUp(alert)
    }
    
    func showAlertError(viewModel: ErrorViewModel?) {
        if viewModel?.error == .network {
            self.view.makeToast("e_commerce_internet_connection_error_description".localized)
        } else if (viewModel?.isValidationError == true) {
            self.view.makeToast(viewModel?.message)
        } else {
            self.view.makeToast("e_commerce_general_error_description".localized)
        }
    }
    
    func showNoConnectionAlert() {
        showAlert(title: "e_commerce_internet_connection_error_title".localized, message: "e_commerce_internet_connection_error_description".localized)
    }
    
    func hideNavigationBar(_ navigationBarisHidden: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = navigationBarisHidden
    }
    
    func createNewRootMainPage() {
        let mainPageVC = SRMainPageViewController(viewModel: SRMainPageViewModel())
        guard var viewControllers = navigationController?.viewControllers else { return }
        mainPageVC.title = SRAppContext.appTitle
        viewControllers.popLast()
        viewControllers.append(mainPageVC)
        self.navigationController?.setViewControllers(viewControllers, animated: true)
    }
   
    func initializePickerView(pickerViewHeight: CGFloat?) -> UIPickerView {
        
        var pickerView = UIPickerView()
        pickerView = UIPickerView.init()
        pickerView.backgroundColor = .buttonLight
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - (pickerViewHeight ?? 0), width: UIScreen.main.bounds.size.width, height: pickerViewHeight ?? 0)
        
        return pickerView
    }
    
    func initializeToolbar(pickerViewModel: PickerViewModel?) -> UIToolbar {
        
        var toolBar = UIToolbar()
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - (pickerViewModel?.pickerViewHeight ?? 0), width: UIScreen.main.bounds.size.width, height: 50))
        UIToolbar.appearance().barTintColor = .buttonLight
        
        toolBar.items = pickerViewModel?.items
        
        return toolBar
        
    }
    
}
