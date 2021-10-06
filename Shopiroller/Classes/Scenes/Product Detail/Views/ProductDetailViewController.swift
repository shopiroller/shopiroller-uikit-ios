//
//  ProductDetailViewController.swift
//  Kingfisher
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher

extension ProductDetailViewController : NibLoadable { }

public class ProductDetailViewController: BaseViewController {

    private let viewModel : ProductDetailViewModel

    public init(viewModel: ProductDetailViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: ProductDetailViewController.nibName, bundle: Bundle(for: ProductDetailViewController.self))
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = ProductDetailViewModel()
        super.init(coder: aDecoder)
    }

}
