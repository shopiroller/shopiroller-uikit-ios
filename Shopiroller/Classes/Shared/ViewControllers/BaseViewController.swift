//
//  BaseViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import Foundation
import UIKit

extension BaseViewController : NibLoadable { }

open class BaseViewController<T>: UIViewController {
    
    internal let viewModel: T
    
    init(_ title: String? = nil, viewModel: T, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = title
    }
    
    @available(*, unavailable) required public init?(coder aDecoder: NSCoder) {
        fatalError("disabled init")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        overrideUserInterfaceStyle = .light
        dismissType = .swipeRightForFullScreen
        setupNavigationBar()
    }
    
    internal func setup() {
    }

    internal func setupNavigationBar(){}
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func viewHeight() -> CGFloat {
        return self.view.frame.height
    }
}
