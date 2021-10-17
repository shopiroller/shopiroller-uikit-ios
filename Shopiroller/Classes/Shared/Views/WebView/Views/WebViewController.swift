//
//  WebViewController.swift
//  Shopiroller
//
//  Created by Görkem on 16.10.2021.
//

import UIKit
import SafariServices
import WebKit

extension WebViewController: NibLoadable { }

private struct Constans {
    
    static var webViewTitle: String { return "product-detail-description-title-text".localized }
}
class WebViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private let viewModel: WebViewViewModel
    
    public init(viewModel: WebViewViewModel = WebViewViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: WebViewController.nibName, bundle: Bundle(for: WebViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = WebViewViewModel()
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        
        view.backgroundColor = .clear
        
        titleView.isHidden = false
        
        titleLabel.textColor = .black
        titleLabel.text = Constans.webViewTitle
        
        dismissButton.setImage(UIImage(systemName: "xmark"))
        dismissButton.tintColor = .black
        
        
        loadWebView()
    }
    
    private func loadWebView() {
        if viewModel.webViewUrl != ""{
            webView.loadHTMLString(viewModel.webViewUrl, baseURL: nil)
        }
    }

    @IBAction func dismissButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
