//
//  UIViewControllerExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 6.10.2021.
//

import Foundation


extension UIViewController {
    
    func prompt(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.isNavigationBarHidden = true
            navigationController.pushViewController(viewController, animated: flag)
            CATransaction.commit()
        } else {
            let navigationController = UINavigationController()
            navigationController.viewControllers = [viewController]
            navigationController.isNavigationBarHidden = true
            navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: flag, completion: completion)
        }
    }
    
    func push(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: true)
        
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
    //
    //    func layover(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    //        viewController.view.backgroundColor = .gunMetal40
    //        viewController.modalPresentationStyle = .overCurrentContext
    //        present(viewController, animated: flag, completion: completion)
    //    }
    //
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
    
    func popToRoot(_ viewController: UIViewController,animated flag: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: false, completion: completion)
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
    
    
}
