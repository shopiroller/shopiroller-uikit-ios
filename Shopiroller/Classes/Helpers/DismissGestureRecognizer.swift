//
//  DismissGestureRecognizer.swift
//  Shopiroller
//
//  Created by Görkem Gür on 3.06.2022.
//
import UIKit

private protocol PropertyStoring {
    associatedtype T = AnyObject
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T
}

private extension PropertyStoring {
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}

extension UIViewController: PropertyStoring {
    
    private struct CustomProperties {
        static var dismissType: DismissType = .disableGesture
        static var dismissTypeGesture: UIGestureRecognizer? = nil
        static var sender: UIPanGestureRecognizer? = nil
    }
    
    public var dismissType: DismissType {
        get {
            let type = getAssociatedObject(&CustomProperties.dismissType, defaultValue: CustomProperties.dismissType as AnyObject) as? DismissType
            return type ?? .disableGesture
        }
        set {
            objc_setAssociatedObject(self, &CustomProperties.dismissType, newValue, .OBJC_ASSOCIATION_RETAIN)
            addPanGesture()
        }
    }
    
    private var dismissTypeGesture: UIGestureRecognizer? {
        get {
            let gesture = getAssociatedObject(&CustomProperties.dismissTypeGesture, defaultValue: CustomProperties.dismissTypeGesture as AnyObject) as? UIGestureRecognizer
            return gesture
        }
        set {
            objc_setAssociatedObject(self, &CustomProperties.dismissTypeGesture, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private func disableDismissTypeGesture() {
        if let dismissType = dismissTypeGesture {
            dismissType.isEnabled = false
            view.removeGestureRecognizer(dismissType)
        }
    }
    
    private func addPanGesture() {
        disableDismissTypeGesture()
        if dismissType != .disableGesture {
            if (navigationController != nil && navigationController!.viewControllers.count == 1) || navigationController == nil {
                if dismissType == .swipeRightForFullScreen {
                    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleEdgePanGesture(_:)))
                    dismissTypeGesture = panGesture
                    view.addGestureRecognizer(panGesture)
                }
            }
        }
    }
    
    @objc private func handleEdgePanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled && (sender.horizontalDirection(target: view) == .Left) {
            CustomProperties.sender = sender
            popCurrentViewController()
        }
    }
    
    private func popCurrentViewController() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.view.endEditing(true)
        if let navigationController = navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: false, completion: nil)
        }
    }
}

public enum DismissType {
    case disableGesture
    case swipeRightForFullScreen
}


extension UIPanGestureRecognizer {
    
    enum GestureDirection {
        case Left
        case Right
    }
    
    /// Get current horizontal direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func horizontalDirection(target: UIView) -> GestureDirection {
        return self.velocity(in: target).x > 0 ? .Right : .Left
    }
    
}
