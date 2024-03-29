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
    
    static var webViewTitle: String { return "e_commerce_product_detail_description".localized }
}
class WebViewController: BaseViewController<WebViewViewModel> {
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    public init(viewModel: WebViewViewModel) {
        super.init(viewModel: viewModel, nibName: WebViewController.nibName, bundle: Bundle(for: WebViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        titleView.isHidden = false
        
        titleLabel.textColor = .textPrimary
        titleLabel.font = .medium20
        titleLabel.text = Constans.webViewTitle
        
        dismissButton.setImage(UIImage(systemName: "xmark"))
        dismissButton.tintColor = .black
        
        
        loadWebView()
    }
    
    private func loadWebView() {
        if let url = viewModel.webViewHtml {
            let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
            webView.loadHTMLString(headerString + url, baseURL: nil)
        } else if let url = viewModel.webViewUrl {
            webView.configuration.mediaTypesRequiringUserActionForPlayback = .all
            webView.configuration.allowsInlineMediaPlayback = false
            webView.allowsLinkPreview = true
            webView.load(URLRequest(url: URL(string:url)!))
        }
    }

    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
