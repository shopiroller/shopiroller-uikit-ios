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
        if let g = dismissTypeGesture {
            g.isEnabled = false
            view.removeGestureRecognizer(g)
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
            if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
                self.view.endEditing(true)
                self.dismiss(animated: true, completion: nil)
            }
        }
}

public enum DismissType {
    case disableGesture
    case swipeRightForFullScreen
}
