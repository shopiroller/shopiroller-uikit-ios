//
//  ThreeDSModalViewController.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 8.11.2021.
//

import Foundation
import UIKit
import WebKit
import SVProgressHUD


protocol ThreeDSModalDelegate {
    func onPaymentSuccess(transactionId: String)
    func onPaymentFailed(message: String)
}

class ThreeDSModalViewController: BaseViewController<ThreeDSModalViewModel> {
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var containerView: UIView!
    
    var delegate: ThreeDSModalDelegate?
    
    init(viewModel: ThreeDSModalViewModel){
        super.init(viewModel: viewModel, nibName: ThreeDSModalViewController.nibName, bundle: Bundle(for: ThreeDSModalViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        containerView.backgroundColor = .white
        
        webView.navigationDelegate = self
        webView.loadHTMLString(viewModel.getRedirectUrl() ?? "", baseURL: nil)

    }
}


extension ThreeDSModalViewController: WKNavigationDelegate {
    
    internal func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.onPaymentFailed(message: "")
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let _ = webView.url else { return }
        guard let url = URLComponents(string: webView.url!.absoluteString) else { return }
        if viewModel.isPageFinished(url: url.string!){
            webView.removeFromSuperview()
            
            dismiss(animated: true, completion: nil)
        }
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
}

