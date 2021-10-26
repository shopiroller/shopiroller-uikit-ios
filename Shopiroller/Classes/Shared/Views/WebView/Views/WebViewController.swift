//
//  WebViewController.swift
//  Shopiroller
//
//  Created by Görkem on 16.10.2021.
//

import UIKit
import SafariServices
import WebKit

private struct Constans {
    
    static var webViewTitle: String { return "product-detail-description-title-text".localized }
}
class WebViewController: BaseViewController<WebViewViewModel> {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    public init(viewModel: WebViewViewModel) {
        super.init(viewModel: viewModel, nibName: WebViewController.nibName, bundle: Bundle(for: WebViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        titleView.isHidden = false
        
        titleLabel.textColor = .black
        titleLabel.text = Constans.webViewTitle
        
        dismissButton.setImage(UIImage(systemName: "xmark"))
        dismissButton.tintColor = .black
        
        
        loadWebView()
    }
    
    private func loadWebView() {
        if viewModel.webViewHtml != "" {
            webView.loadHTMLString(viewModel.webViewHtml ?? "", baseURL: nil)
        }
    }

    @IBAction func dismissButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
